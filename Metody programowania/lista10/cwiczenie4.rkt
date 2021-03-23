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
(struct let-lazy     (x e1 e2)  #:transparent)

;; wartości zwracane przez interpreter

(struct val-symbol (s)   #:transparent)
(struct closure (x b e)) ; Racket nie jest transparentny w tym miejscu,
; to my też nie będziemy
(struct blackhole ()) ; lepiej tzrymać się z daleka!
(struct closure-let (b e))
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
    [(variable x)
     (let ((res (env-lookup x env)))
         (match res
           [(closure-let b e) (let ((val (eval b e)))
                                (begin (env-update! x val env)
                                       val))]
           [_ res]))]
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
    [(lambda-expr x b) (closure x b env)]
    [(app-expr f e)    (let ((vf (eval f env))
                             (ve (eval e env)))
                         (match vf
                           [(closure x b c-env)
                            (eval b (env-add x ve c-env))]
                           [_ (error "application: not a function :(")]))]
    [(set!-expr x e)
     (env-update! x (eval e env) env)]
    [(let-lazy x e1 e2)
     (let ((v1 (closure-let e1 env)))
       (eval e2 (env-add x v1 env)))]
    ))

(define (run e)
  (eval e (env-empty)))

(run (let-lazy 'x (op '+ (const 5) (const 6)) (variable 'x)))