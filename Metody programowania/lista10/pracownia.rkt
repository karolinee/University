#lang racket

(require rackunit)
(require rackunit/text-ui)

;; definicja wyrażeń

(struct variable     (x)        #:transparent)
(struct const        (val)      #:transparent)
(struct op           (symb l r) #:transparent)
(struct let-expr     (x e1 e2)  #:transparent)
(struct if-expr      (b t e)    #:transparent)
(struct cons-expr    (l r)      #:transparent)
(struct car-expr     (p)        #:transparent)
(struct cdr-expr     (p)        #:transparent)
(struct pair?-expr   (p)        #:transparent)
(struct null-expr    ()         #:transparent)
(struct null?-expr   (e)        #:transparent)
(struct symbol-expr  (v)        #:transparent)
(struct symbol?-expr (e)        #:transparent)
(struct lambda-expr  (xs b)     #:transparent)
(struct app-expr     (f es)     #:transparent)
(struct apply-expr   (f e)      #:transparent)

(define (expr? e)
  (match e
    [(variable s)       (symbol? s)]
    [(const n)          (or (number? n)
                            (boolean? n))]
    [(op s l r)         (and (member s '(+ *))
                             (expr? l)
                             (expr? r))]
    [(let-expr x e1 e2) (and (symbol? x)
                             (expr? e1)
                             (expr? e2))]
    [(if-expr b t e)    (andmap expr? (list b t e))]
    [(cons-expr l r)    (andmap expr? (list l r))]
    [(car-expr p)       (expr? p)]
    [(cdr-expr p)       (expr? p)]
    [(pair?-expr p)     (expr? p)]
    [(null-expr)        true]
    [(null?-expr p)     (expr? p)]
    [(symbol-expr v)    (symbol? v)]
    [(symbol?-expr p)   (expr? p)]
    [(lambda-expr xs b) (and (list? xs)
                             (andmap symbol? xs)
                             (expr? b)
                             (not (check-duplicates xs)))]
    [(app-expr f es)    (and (expr? f)
                             (list? es)
                             (andmap expr? es))]
    [(apply-expr f e)   (and (expr? f)
                             (expr? e))]
    [_                  false]))

;; wartości zwracane przez interpreter

(struct val-symbol (s)   #:transparent)
(struct closure (xs b env) #:transparent)

(define (my-value? v)
  (or (number? v)
      (boolean? v)
      (and (pair? v)
           (my-value? (car v))
           (my-value? (cdr v)))
      ; null-a reprezentujemy symbolem (a nie racketowym
      ; nullem) bez wyraźnej przyczyny
      (and (symbol? v) (eq? v 'null))
      (and (val-symbol? v) (symbol? (val-symbol-s v)))
      (and (closure? v) (list? (closure-xs v)) (andmap symbol? (closure-xs v)) (expr? (closure-b v)) (not (check-duplicates (closure-xs v))))))

;; wyszukiwanie wartości dla klucza na liście asocjacyjnej
;; dwuelementowych list

(define (lookup x xs)
  (cond
    [(null? xs)
     (error x "unknown identifier :(")]
    [(eq? (caar xs) x) (cadar xs)]
    [else (lookup x (cdr xs))]))

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
              (eq? ,(lambda (x y) (eq? (val-symbol-s x)
                                       (val-symbol-s y))))
              )))

;; interfejs do obsługi środowisk

(define (env-empty) null)
(define env-lookup lookup)
(define (env-add x v env) (cons (list x v) env))

(define (env? e)
  (and (list? e)
       (andmap (lambda (xs) (and (list? xs)
                                 (= (length xs) 2)
                                 (symbol? (first xs)))) e)))

; funkcje pomocnicze do evaluowania lambd
(define (eval-all xs env)
  (if (null? xs)
      null
      (cons (eval (car xs) env) (eval-all (cdr xs) env))))
(define (add-all arg val env)
  (if (null? arg)
      env
      (add-all (cdr arg) (cdr val) (env-add (car arg) (car val) env))))
(define (expr->list e)
  (if (eq? e 'null)
      null
      (cons (car e) (expr->list (cdr e)))))


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
    [(lambda-expr xs b)(closure xs b env)]
    [(app-expr f es)   (let ((vf (eval f env)))
                         (match vf
                           [(closure x b c-env)
                            (if (not (= (length es) (length x)))
                                (error "number of arguments does not match")
                                (let ((ves (eval-all es c-env)))
                                  (eval b (add-all x ves c-env))))]
                           [_ (error "application: not a function :(")]))]
    [(apply-expr f e) (let ((vf (eval f env))
                            (ve (expr->list (eval e env))))
                         (match vf
                           [(closure x b c-env)
                            (if (not (= (length ve) (length x)))
                                (error "number of arguments does not match")
                                (eval b (add-all x ve c-env)))]
                           [_ (error "application: not a function :(")]))]))

(define (run e)
  (eval e (env-empty)))

(define tests
  (test-suite
   "Testy implementacji wieloargumentowej lambdy i apply"

   (test-case
    "Testy lambdy"
    (check-equal?
     (run (lambda-expr '(x) (variable 'x)))
     (closure '(x) (variable 'x) '())
     "Lambda 1-arumentowa i puste środowisko")  
    (check-equal?
     (run (lambda-expr '(x y) (op '+ (variable 'x) (variable 'y))))
     (closure '(x y) (op '+ (variable 'x) (variable 'y)) '())
     "Lambda 2-argumentowa i puste środowisko")   
    (check-equal?
     (eval (lambda-expr '(x y z a b) (op '+ (variable 'x) (variable 'y))) '((x 5) (y 7)))
     (closure '(x y z a b) (op '+ (variable 'x) (variable 'y)) '((x 5) (y 7)))
     "Lambda >2 argumentowa i niepuste środowisko"))

   
   (test-case
    "Testy app-expr"
    (check-exn
     exn:fail?
     (lambda () (run (app-expr (lambda-expr '(x) (variable 'x)) (list (const 4) (const 5)))))
     "Niezgodna liczba argumentów -> błąd")    
    (check-exn
     exn:fail?
     (lambda () (run (app-expr (lambda-expr '(x y z) (variable 'x)) (list (const 4) (const 5)))))
     "Niezgodna liczba argumentów -> błąd")    
    (check-not-exn
     (lambda () (run (app-expr (lambda-expr '(x y) (variable 'x)) (list (const 4) (const 5)))))
     "Zgodna liczba argumentów -> brak błędu")
    (check-equal?
     (run (app-expr (lambda-expr '(x) (variable 'x)) (list (const 4))))
     4
     "Lambda 1-argumentowa i puste środowisko")
    (check-equal?
     (run (app-expr (lambda-expr '(x y) (op '+ (variable 'x) (variable 'y))) (list (const 4) (const 5))))
     9
     "Lambda 2-argumentowa i puste środowisko")
    (check-equal?
     (eval (app-expr (lambda-expr '(x) (variable 'x)) (list (op '+ (variable 'c) (const 1)))) '((a 4) (c 5)))
     6
     "Lambda 1-arumentowa i niepuste środowisko")
    (check-equal?
     (eval (app-expr (lambda-expr '(x y) (op '+ (variable 'x) (variable 'y))) (list (const 0) (variable 'x))) '((x 4) (c 5)))
     4
     "Lambda 2-arumentowa i niepuste środowisko"))

    (test-case
    "Testy apply-expr"
    (check-exn
     exn:fail?
     (lambda () (run (apply-expr (lambda-expr '(x) (variable 'x)) (null-expr))))
     "Niezgodna liczba argumentów -> błąd")
    (check-exn
     exn:fail?
     (lambda () (run (apply-expr (lambda-expr '(x y) (variable 'x)) (cons-expr (const 5) (cons-expr (const 6) (cons-expr (const 7) (null-expr)))))))
     "Niezgodna liczba argumentów -> błąd")
    (check-not-exn
     (lambda () (run (apply-expr (lambda-expr '(x y) (variable 'x)) (cons-expr (const 5) (cons-expr (const 6) (null-expr))))))
     "Zgodna liczba argumentów -> brak błędu")
    (check-equal?
     (run (apply-expr (lambda-expr '(x) (variable 'x)) (cons-expr (const 4) (null-expr))))
     4
     "Lambda 1-argumentowa i puste środowisko")
    (check-equal?
     (run (apply-expr (lambda-expr '(x y) (op '+ (variable 'x) (variable 'y))) (cons-expr (const 5) (cons-expr (const 6) (null-expr)))))
     11
     "Lambda 2-argumentowa i puste środowisko")
    (check-equal?
     (eval (apply-expr (lambda-expr '(x y) (op '+ (variable 'x) (variable 'y))) (cons-expr (const 5) (cons-expr (variable 'x) (null-expr)))) '((x 4) (c 5)))
     9
     "Lambda 2-arumentowa i niepuste środowisko")
    
    )
   ))

(run-tests tests)