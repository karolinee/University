#lang racket

(provide (all-defined-out))

;; definicja wyrażeń

(struct variable     (x)        #:transparent)
(struct const        (val)      #:transparent)
(struct op           (symb l r) #:transparent)
(struct let-expr     (x e1 e2)  #:transparent)
(struct letrec-expr  (x e1 e2)  #:transparent)
(struct if-expr      (b t e)    #:transparent)
(struct cons-expr    (l r)      #:transparent)
(struct car-expr     (p)        #:transparent)
(struct cdr-expr     (p)        #:transparent)
(struct pair?-expr   (p)        #:transparent)
(struct null-expr    ()         #:transparent)
(struct null?-expr   (e)        #:transparent)
(struct symbol-expr  (v)        #:transparent)
(struct symbol?-expr (e)        #:transparent)
(struct lambda-expr  (x b)      #:transparent)
(struct app-expr     (f e)      #:transparent)
(struct set!-expr    (x v)      #:transparent)

;; wartości zwracane przez interpreter

(struct val-symbol (s)   #:transparent)
(struct closure (x b e)) ; Racket nie jest transparentny w tym miejscu,
; to my też nie będziemy
(struct blackhole ()) ; lepiej tzrymać się z daleka!


(define (find-variables f)
  (define (aux f xs)
    (match f
      [(const f) xs]
       [(op s l r)
        (append (aux l null) (aux r null) xs)]
        [(let-expr x e1 e2) (append (aux e1 null) (aux e2 null) xs)]
        [(letrec-expr x e1 e2) (append (aux e1 null) (aux e2 null) xs)]
        [(variable x) (cons x xs)]
        [(if-expr b t e) (append (aux b null) (aux t null) (aux e null) xs)]
        [(cons-expr l r) (append (aux l null) (aux r null))]
        [(car-expr p) (append (aux p null) xs)]
        [(cdr-expr p) (append (aux p null) xs)]
        [(pair?-expr p) (append (aux p null) xs)]
        [(null-expr) xs]
        [(null?-expr e) (append (aux e null) xs)]
        [(symbol-expr v) xs]
        [(lambda-expr x b) (append (aux b null) xs)]
        [(app-expr f e) (append (aux f null) (aux e null) xs)]
        [(set!-expr x e) (append (aux e null) (cons x xs))]))
    (set->list (list->set(aux f null))))

                     
(define (smaller-env env xs)
  (define (aux env)
    (if (null? env)
        null
        (if (member (mcar (mcar env)) xs)
            (mcons (mcar env) (aux (mcdr env)))
            (aux (mcdr env)))))
  (aux env))
;; wyszukiwanie wartości dla klucza na liście asocjacyjnej
;; dwuelementowych list

(define (lookup x xs)
  (cond
    [(null? xs)
     (error x "unknown identifier :(")]
    [(eq? (caar xs) x) (cadar xs)]
    [else (lookup x (cdr xs))]))

(define (mlookup x xs)
  (cond
    [(null? xs)
     (error x "unknown identifier :(")]
    [(eq? (mcar (mcar xs)) x)
     (match (mcar (mcdr (mcar xs)))
       [(blackhole) (error "Stuck in a black hole :(")]
       [x x])]
    [else (mlookup x (mcdr xs))]))

(define (mupdate! x v xs)
  (define (update! ys)
    (cond
      [(null? ys) (error x "unknown identifier :(")]
      [(eq? x (mcar (mcar ys)))
       (set-mcar! (mcdr (mcar ys)) v)]
      [else (update! (mcdr ys))]))
  (begin (update! xs) xs))

;; kilka operatorów do wykorzystania w interpreterze

(define (op-to-proc x)
  (lookup x `(
              (+ ,+)
              (* ,*)
              (- ,-)
              (/ ,/)
              (> ,>)
              (>= ,>=)
              (< ,<)
              (<= ,<=)
              (= ,=)
              (% ,modulo)
              (!= ,(lambda (x y) (not (= x y)))) 
              (&& ,(lambda (x y) (and x y)))
              (|| ,(lambda (x y) (or x y)))
              (eq? ,(lambda (x y) (eq? (val-symbol-s x)
                                       (val-symbol-s y))))
              )))

;; interfejs do obsługi środowisk

(define (env-empty) null)
(define env-lookup mlookup)
(define (env-add x v env)
  (mcons (mcons x (mcons v null)) env))
(define env-update! mupdate!)

;; interpretacja wyrażeń

(define (eval e env)
  (match e
    [(const n) n]
    [(op s l r)
     ((op-to-proc s) (eval l env)
                     (eval r env))]
    [(let-expr x e1 e2)
     (let ((v1 (eval e1 env)))
       (eval e2 (env-add x v1 env)))]
    [(letrec-expr x e1 e2)
     (let* ((new-env (env-add x (blackhole) env))
            (v1 (eval e1 new-env)))
       (eval e2 (env-update! x v1 new-env)))]
    [(variable x) (env-lookup x env)]
    [(if-expr b t e) (if (eval b env)
                         (eval t env)
                         (eval e env))]
    [(cons-expr l r)
     (let ((vl (eval l env))
           (vr (eval r env)))
       (cons vl vr))]
    [(car-expr p)      (car (eval p env))]
    [(cdr-expr p)      (cdr (eval p env))]
    [(pair?-expr p)    (pair? (eval p env))]
    [(null-expr)       'null]
    [(null?-expr e)    (eq? (eval e env) 'null)]
    [(symbol-expr v)   (val-symbol v)]
    [(lambda-expr x b) (closure x b (smaller-env env (find-variables b)))]
    [(app-expr f e)    (let ((vf (eval f env))
                             (ve (eval e env)))
                         (match vf
                           [(closure x b c-env)
                            (eval b (env-add x ve c-env))]
                           [_ (error "application: not a function :(")]))]
    [(set!-expr x e)
     (env-update! x (eval e env) env)]
    ))

(define (run e)
  (eval e (env-empty)))

;; przykład

(define fact-in-expr
  (letrec-expr 'fact (lambda-expr 'n
                                  (if-expr (op '= (const 0) (variable 'n))
                                           (const 1)
                                           (op '* (variable 'n)
                                               (app-expr (variable 'fact)
                                                         (op '- (variable 'n)
                                                             (const 1))))))
               (app-expr (variable 'fact)
                         (const 5))))

(define (append-letrec xs ys)
  (letrec-expr 'append (lambda-expr 'n
                                    (if-expr (null?-expr (car-expr (variable 'n)))
                                             (cdr-expr (variable 'n))
                                             (cons-expr (car-expr (car-expr (variable 'n))) (app-expr (variable 'append) (cons-expr (cdr-expr (car-expr (variable 'n))) (cdr-expr (variable 'n)))))))
               (app-expr (variable 'append)
                         (cons-expr xs ys))))
                         

(run (append-letrec (cons-expr (const 1) (cons-expr (const 2) (null-expr))) (cons-expr (const 3) (cons-expr (const 4) (null-expr)))))

(run (cons-expr (const 1) (cons-expr (const 2) (null-expr))))

(define (reverse-letrec xs)
  (letrec-expr 'reverse (lambda-expr 'n
                                     (if-expr (null?-expr (variable 'n))
                                              (null-expr)
                                              (append-letrec (app-expr (variable 'reverse) (cdr-expr (variable 'n))) (cons-expr (car-expr (variable 'n)) (null-expr)))))
               (app-expr (variable 'reverse)
                         xs)))

(run (reverse-letrec  (cons-expr (const 1) (cons-expr (const 2) (null-expr)))))



(define (map-letrec f xs)
  (letrec-expr 'map (lambda-expr 'n
                                 (if-expr (null?-expr (cdr-expr (variable 'n)))
                                          (null-expr)
                                          (cons-expr (app-expr (car-expr (variable 'n)) (car-expr (cdr-expr (variable 'n)))) (app-expr (variable 'map) (cons-expr (car-expr (variable 'n)) (cdr-expr (cdr-expr (variable 'n))))))))
                                                     (app-expr (variable 'map)
                                                               (cons-expr f xs))))

(run (map-letrec (lambda-expr 'x (op '+ (variable 'x) (const 1))) (cons-expr (const 1) (cons-expr (const 2) (null-expr)))))


                                 
(define (eq-str? f g)
  (eq? (vector-ref (struct->vector f) 0)
       (vector-ref (struct->vector g) 0)))


(define (alpha-equal f g)
  (if (eq-str? f g)
      (match f
        [(const n) (equal? n (const-val g))]
        [(op op l p) (and (eq? op (op-symb g))(alpha-equal l (op-l g)) (alpha-equal p (op-r g)))])
      false))