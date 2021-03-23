#lang racket


(require rackunit)
(require rackunit/text-ui)

;; definicja wyrażeń z let-wyrażeniami i if-wyrażeniami
(struct variable (x)         #:transparent)
(struct const    (val)       #:transparent)
(struct op       (symb l r)  #:transparent)
(struct let-expr (x e1 e2)   #:transparent)
(struct if-expr  (b t e)     #:transparent)

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
    [_                  false]))

;; definicja instrukcji w języku WHILE
(struct skip      ()       #:transparent) ; skip
(struct comp      (s1 s2)  #:transparent) ; s1; s2
(struct assign    (x e)    #:transparent) ; x := e
(struct while     (b s)    #:transparent) ; while (b) s
(struct if-stm    (b t e)  #:transparent) ; if (b) t else e
(struct var-block (x e s)  #:transparent) ; var x := e in s

(define (stm? e)
  (match e
    [(skip) true]
    [(comp s1 s2)   (and (stm? s1) (stm? s2))]
    [(assign x e)   (and (symbol? x) (expr? e))]
    [(while b s)    (and (expr? b) (stm? s))]
    [(if-stm b t e) (and (expr? b) (stm? t) (stm? e))]
    [_ false]))
  
;; wyszukiwanie wartości dla klucza na liście asocjacyjnej
;; dwuelementowych list
(define (lookup x xs)
  (cond
    [(null? xs)
     (error x "unknown identifier :(")]
    [(eq? (caar xs) x) (cadar xs)]
    [else (lookup x (cdr xs))]))

;; lookup dla mutowalnej listy mutowalnych par 
(define (mlookup x xs)
  (cond
    [(null? xs) (error x "unknown identifier :(")]
    [(eq? (mcar (mcar xs)) x)
     (mcdr (mcar xs))]
    [else (mlookup x (mcdr xs))]))

;; aktualizacja środowiska dla danej zmiennej (koniecznie już
;; istniejącej w środowisku!)
(define (update x v xs)
  (cond
    [(null? xs)
     (error x "unknown identifier :(")]
    [(eq? (caar xs) x)
     (cons (list (caar xs) v) (cdr xs))]
    [else
     (cons (car xs) (update x v (cdr xs)))]))

;; update dla mutowalnej listy mutowalnych par 
(define (mupdate x v xs)
  (define (aux acc)
    (cond
      [(null? acc) (error x "unknown identifier :(")]
      [(eq? (mcar (mcar acc)) x)
       (set-mcdr! (mcar acc) v)]
      [else (aux (mcdr acc))]))
  (aux xs)
  xs)

;; kilka operatorów do wykorzystania w interpreterze
(define (op-to-proc x)
  (lookup x `((+ ,+)
              (* ,*)
              (- ,-)
              (/ ,/)
              (%, modulo)
              (> ,>)
              (>= ,>=)
              (< ,<)
              (<= ,<=)
              (= ,=)
              (!= ,(lambda (x y) (not (= x y)))) 
              (&& ,(lambda (x y) (and x y)))
              (|| ,(lambda (x y) (or x y)))
              )))

;; interfejs do obsługi środowisk
(define (env-empty) null)
(define env-lookup mlookup)
(define (env-add x v env) (mcons (mcons x v) env))
(define env-update mupdate)
(define env-discard mcdr)
(define (env-from-assoc-list xs) (list-to-mlist xs))

;; konwersja listy par na mutowalną listę mutowalnych par
(define (list-to-mlist xs)
  (if (null? xs)
      null
      (let ((elem (car xs)))
            (mcons (mcons (car elem) (car (cdr elem))) (list-to-mlist (cdr xs))))))

;; ewaluacja wyrażeń ze środowiskiem
(define (eval e env)
  (match e
    [(const n) n]
    [(op s l r) ((op-to-proc s) (eval l env)
                                (eval r env))]
    [(let-expr x e1 e2)
     (let ((v1 (eval e1 env)))
       (eval e2 (env-add x v1 env)))]
    [(variable x) (env-lookup x env)]
    [(if-expr b t e) (if (eval b env)
                         (eval t env)
                         (eval e env))]))

;; interpretacja programów w języku WHILE, gdzie środowisko m to stan
;; pamięci. Interpreter to procedura, która dostaje program i początkowy
;; stan pamięci, a której wynikiem jest końcowy stan pamięci. Pamięć to
;; aktualne środowisko zawierające wartości zmiennych
(define (interp p m)
  (match p
    [(skip) m]
    [(comp s1 s2) (interp s2 (interp s1 m))]
    [(assign x e)
     (env-update x (eval e m) m)]
    [(while b s)
     (if (eval b m)
         (interp p (interp s m))
         m)]
    [(var-block x e s)
     (env-discard
      (interp s (env-add x (eval e m) m)))]
    [(if-stm b t e) (if (eval b m)
                        (interp t m)
                        (interp e m))]))


;; silnia zmiennej i
(define fact-in-WHILE
  (var-block 'x (const 0)                                           ; var x := 0 in
     (comp (assign 'x (const 1))                                    ;   x := 1
     (comp (while (op '> (variable 'i) (const 0))                   ;   while (i > 0)
              (comp (assign 'x (op '* (variable 'x) (variable 'i))) ;     x := x * i
                    (assign 'i (op '- (variable 'i) (const 1)))))   ;     i := i - 1
           (assign 'i (variable 'x))))))                            ;   i := x

(define (factorial n)
  (env-lookup 'i (interp fact-in-WHILE
                         (env-from-assoc-list `((i ,n))))))

(define tests
  (test-suite
   "Testy środowiska w postaci mutowalnej listy nutowalnych par"
   (test-case
    "Podstawowe testy obslugi srodowiska"
    (check-equal? (list-to-mlist '((x 4) (y 7) (z 2))) (mcons (mcons 'x 4) (mcons (mcons 'y 7) (mcons (mcons 'z 2) null))) "list-to-mlist")
    (check-equal? (env-discard (mcons (mcons 'x 4) (mcons (mcons 'y 7) (mcons (mcons 'z 2) null)))) (mcons (mcons 'y 7) (mcons (mcons 'z 2) null))"env-discard")
    (check-equal? (env-lookup 'y (mcons (mcons 'x 4) (mcons (mcons 'y 7) (mcons (mcons 'z 2) null)))) 7 "env-lookup")
    (check-equal? (env-update 'y 3 (mcons (mcons 'x 4) (mcons (mcons 'y 7) (mcons (mcons 'z 2) null)))) (mcons (mcons 'x 4) (mcons (mcons 'y 3) (mcons (mcons 'z 2) null))) "env-update")
    (check-equal? (env-add 'x 9 (mcons (mcons 'y 7) (mcons (mcons 'z 2) null))) (mcons (mcons 'x 9) (mcons (mcons 'y 7) (mcons (mcons 'z 2) null))) "env-add"))
   (test-case
    "Testy interpretera na nowej reprezentacji środowiska (za pomocą silni)"
    (check-equal? (factorial 0) 1)
    (check-equal? (factorial 1) 1)
    (check-equal? (factorial 2) 2)
    (check-equal? (factorial 3) 6)
    (check-equal? (factorial 10) 3628800))))


(run-tests tests)



