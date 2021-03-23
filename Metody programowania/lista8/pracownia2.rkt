#lang racket


(module my-module-1 racket
  (provide (all-defined-out)) ; wszystkie definicje z modułu są widoczne na zewnątrz
  ;; definicja wyrażeń z let-wyrażeniami i if-wyrażeniami

  ;; brak optymalizacji
  
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
  (define env-lookup lookup)
  (define (env-add x v env) (cons (list x v) env))
  (define env-update update)
  (define env-discard cdr)
  (define (env-from-assoc-list xs) xs)

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

  (define sum-WHILE
    (var-block 'sum (const 0)
               (comp
                (while (op '< (variable 'b) (op '+ (variable 'e) (const 1)))
                       (comp (assign 'sum (op '+ (variable 'sum) (variable 'b)))
                             (assign 'b (op '+ (variable 'b) (const 1)))))
                (assign 'e (variable 'sum)))))

  (define NWD-WHILE
    (while (op '!= (variable 'a) (variable 'b))
           (if-stm (op '> (variable 'a) (variable 'b))
                   (assign 'a (op '- (variable 'a) (variable 'b)))
                   (assign 'b (op '- (variable 'b) (variable 'a))))))

  (define fib-WHILE
    (var-block 'f1 (const 0)
               (var-block 'f2 (const 1)
                          (comp (while (op '> (variable 'i) (const 0))
                                       (var-block 'f3 (op '+ (variable 'f1) (variable 'f2))
                                                  (comp (assign 'f1 (variable 'f2))
                                                        (comp (assign 'f2 (variable 'f3))
                                                              (assign 'i (op '- (variable 'i) (const 1)))))))
                                (assign 'i (variable 'f1))))))
  )

(module my-module-2 racket
  (provide (all-defined-out)) ; wszystkie definicje z modułu są widoczne na zewnątrz
  ;; definicja wyrażeń z let-wyrażeniami i if-wyrażeniami

  ;; z optymalizacją
  
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

  ;  (define (mlookup x xs)
  ;    (if (null? xs)
  ;        (error x "unknown identifier :(")
  ;        (let ((elem (mcar xs)))
  ;          (if (eq? (mcar elem) x)
  ;              (mcdr elem)
  ;              (mlookup x (mcdr xs))))))

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

  ;  (define (mupdate x v xs)
  ;    (define (aux acc)
  ;      (if (null? acc)
  ;          (error x "unknown identifier :(")
  ;          (let ((elem (mcar acc)))
  ;            (if (eq? (mcar elem) x)
  ;                (set-mcdr! elem v)
  ;                (aux (mcdr acc))))))
  ;    (aux xs)
  ;    xs)

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

  (define sum-WHILE
    (var-block 'sum (const 0)
               (comp
                (while (op '< (variable 'b) (op '+ (variable 'e) (const 1)))
                       (comp (assign 'sum (op '+ (variable 'sum) (variable 'b)))
                             (assign 'b (op '+ (variable 'b) (const 1)))))
                (assign 'e (variable 'sum)))))


  (define NWD-WHILE
    (while (op '!= (variable 'a) (variable 'b))
           (if-stm (op '> (variable 'a) (variable 'b))
                   (assign 'a (op '- (variable 'a) (variable 'b)))
                   (assign 'b (op '- (variable 'b) (variable 'a))))))

  (define fib-WHILE
    (var-block 'f1 (const 0)
               (var-block 'f2 (const 1)
                          (comp (while (op '> (variable 'i) (const 0))
                                       (var-block 'f3 (op '+ (variable 'f1) (variable 'f2))
                                                  (comp (assign 'f1 (variable 'f2))
                                                        (comp (assign 'f2 (variable 'f3))
                                                              (assign 'i (op '- (variable 'i) (const 1)))))))
                                (assign 'i (variable 'f1))))))

  )


;; Ponieważ w modułach są procedury o takich samych nazwach,
;; importując je, każemy dodać prefiks "mod...:" (nie jest to słowo
;; kluczowe, a identyfikator wiązany przez konstrukcję "prefix-in")
;; żeby odróżnić, z którego modułu pochodzi procedura.
(require (prefix-in mod1: 'my-module-1)) ;;bez optymalizacji
(require (prefix-in mod2: 'my-module-2)) ;;z optymalizacją


;;Funkcje liczące sume liczb z zakresu
(define (sum p k)
  (mod1:env-lookup 'e (mod1:interp mod1:sum-WHILE (mod1:env-from-assoc-list `((b ,p) (e ,k))))))
(define (sum-opt p k)
  (mod2:env-lookup 'e (mod2:interp mod2:sum-WHILE (mod2:env-from-assoc-list `((b ,p) (e ,k))))))

(define (sum-racket p k)
  (define (aux p acc)
    (if (= p (+ k 1))
        acc
        (aux (+ 1 p) (+ acc p))))
  (aux p 0))



;;Funckje liczące NWD
(define (NWD n m)
  (mod1:env-lookup 'a (mod1:interp mod1:NWD-WHILE (mod1:env-from-assoc-list `((a ,n) (b ,m))))))
(define (NWD-opt n m)
  (mod2:env-lookup 'a (mod2:interp mod2:NWD-WHILE (mod2:env-from-assoc-list `((a ,n) (b ,m))))))

(define (NWD-racket n m)
  (if (not (= n m))
      (if (< n m)
          (NWD-racket n (- m n))
          (NWD-racket (- n m) m))
      n))


;;Funkcje liczące n-tą liczbę Fibbonacciego
(define (fib n)
  (mod1:env-lookup 'i (mod1:interp mod1:fib-WHILE (mod1:env-from-assoc-list `((i ,n))))))
(define (fib-opt n)
  (mod2:env-lookup 'i (mod2:interp mod2:fib-WHILE (mod2:env-from-assoc-list `((i ,n))))))
                   
(define (fib-racket n)
  (define (aux n f1 f2)
    (if (= n 0)
        f1
        (let ((f3 (+ f2 f1)))
          (aux (- n 1) f2 f3))))
  (aux n 0 1))


;; Testy wydajnościowe
(define (test)
  (begin
    (display "wait...\n")
    (flush-output (current-output-port))
    (test-performance-sum-1-1000)
    (test-performance-sum-1-1000000)
    (test-performance-NWD-1-1000)
    (test-performance-NWD-1-1000000)
    (test-performance-fib-1000)
    (test-performance-fib-10000)
    (test-performance-fib-1000000)))


(define (test-performance-sum-1-1000)
  (let-values
      (((r1 cpu1 real1 gc1) (time-apply sum (list 1 1000)))
       ((r2 cpu2 real2 gc2) (time-apply sum-opt (list 1 1000)))
       ((r3 cpu3 real3 gc3) (time-apply sum-racket (list 1 1000))))
    (begin
      (display "\nliczenie sumy liczb od 1 do 1000:\n"  )
      (display "without opt  time (cpu, real, gc): ")
      (display cpu1)  (display ", ")
      (display real1) (display ", ")
      (display gc1)   (display "\n")
      (display "with opt time (cpu, real, gc): ")
      (display cpu2)  (display ", ")
      (display real2) (display ", ")
      (display gc2)   (display "\n")
      (display "racket time (cpu, real, gc): ")
      (display cpu3)  (display ", ")
      (display real3) (display ", ")
      (display gc3)   (display "\n"))))


(define (test-performance-sum-1-1000000)
  (let-values
      (((r1 cpu1 real1 gc1) (time-apply sum (list 1 1000000)))
       ((r2 cpu2 real2 gc2) (time-apply sum-opt (list 1 1000000)))
       ((r3 cpu3 real3 gc3) (time-apply sum-racket (list 1 1000000))))
    (begin
      (display "\nliczenie sumy liczb od 1 do 1000000:\n"  )
      (display "without opt  time (cpu, real, gc): ")
      (display cpu1)  (display ", ")
      (display real1) (display ", ")
      (display gc1)   (display "\n")
      (display "with opt time (cpu, real, gc): ")
      (display cpu2)  (display ", ")
      (display real2) (display ", ")
      (display gc2)   (display "\n")
      (display "racket time (cpu, real, gc): ")
      (display cpu3)  (display ", ")
      (display real3) (display ", ")
      (display gc3)   (display "\n"))))

(define (test-performance-NWD-1-1000)
  (let-values
      (((r1 cpu1 real1 gc1) (time-apply NWD (list 1 1000)))
       ((r2 cpu2 real2 gc2) (time-apply NWD-opt (list 1 1000)))
       ((r3 cpu3 real3 gc3) (time-apply NWD-racket (list 1 1000))))
    (begin
      (display "\nliczenie NWD liczb 1 1000:\n"  )
      (display "without opt  time (cpu, real, gc): ")
      (display cpu1)  (display ", ")
      (display real1) (display ", ")
      (display gc1)   (display "\n")
      (display "with opt time (cpu, real, gc): ")
      (display cpu2)  (display ", ")
      (display real2) (display ", ")
      (display gc2)   (display "\n")
      (display "racket time (cpu, real, gc): ")
      (display cpu3)  (display ", ")
      (display real3) (display ", ")
      (display gc3)   (display "\n"))))


(define (test-performance-NWD-1-1000000)
  (let-values
      (((r1 cpu1 real1 gc1) (time-apply NWD (list 1 1000000)))
       ((r2 cpu2 real2 gc2) (time-apply NWD-opt (list 1 1000000)))
       ((r3 cpu3 real3 gc3) (time-apply NWD-racket (list 1 1000000))))
    (begin
      (display "\nliczenie NWD liczb 1 1000000:\n"  )
      (display "without opt  time (cpu, real, gc): ")
      (display cpu1)  (display ", ")
      (display real1) (display ", ")
      (display gc1)   (display "\n")
      (display "with opt time (cpu, real, gc): ")
      (display cpu2)  (display ", ")
      (display real2) (display ", ")
      (display gc2)   (display "\n")
      (display "racket time (cpu, real, gc): ")
      (display cpu3)  (display ", ")
      (display real3) (display ", ")
      (display gc3)   (display "\n"))))

(define (test-performance-fib-10000)
  (let-values
      (((r1 cpu1 real1 gc1) (time-apply fib (list 10000)))
       ((r2 cpu2 real2 gc2) (time-apply fib-opt (list 10000)))
       ((r3 cpu3 real3 gc3) (time-apply fib-racket (list 10000))))
    (begin
      (display "\nliczenie 10000-tej liczby fib:\n"  )
      (display "without opt  time (cpu, real, gc): ")
      (display cpu1)  (display ", ")
      (display real1) (display ", ")
      (display gc1)   (display "\n")
      (display "with opt time (cpu, real, gc): ")
      (display cpu2)  (display ", ")
      (display real2) (display ", ")
      (display gc2)   (display "\n")
      (display "racket time (cpu, real, gc): ")
      (display cpu3)  (display ", ")
      (display real3) (display ", ")
      (display gc3)   (display "\n"))))

(define (test-performance-fib-1000000)
  (let-values
      (((r1 cpu1 real1 gc1) (time-apply fib (list 1000000)))
       ((r2 cpu2 real2 gc2) (time-apply fib-opt (list 1000000)))
       ((r3 cpu3 real3 gc3) (time-apply fib-racket (list 1000000))))
    (begin
      (display "\nliczenie 1000000-tej liczby fib:\n"  )
      (display "without opt  time (cpu, real, gc): ")
      (display cpu1)  (display ", ")
      (display real1) (display ", ")
      (display gc1)   (display "\n")
      (display "with opt time (cpu, real, gc): ")
      (display cpu2)  (display ", ")
      (display real2) (display ", ")
      (display gc2)   (display "\n")
      (display "racket time (cpu, real, gc): ")
      (display cpu3)  (display ", ")
      (display real3) (display ", ")
      (display gc3)   (display "\n"))))

(define (test-performance-fib-1000)
  (let-values
      (((r1 cpu1 real1 gc1) (time-apply fib (list 1000)))
       ((r2 cpu2 real2 gc2) (time-apply fib-opt (list 1000)))
       ((r3 cpu3 real3 gc3) (time-apply fib-racket (list 1000))))
    (begin
      (display "\nliczenie 1000-tej liczby fib:\n"  )
      (display "without opt  time (cpu, real, gc): ")
      (display cpu1)  (display ", ")
      (display real1) (display ", ")
      (display gc1)   (display "\n")
      (display "with opt time (cpu, real, gc): ")
      (display cpu2)  (display ", ")
      (display real2) (display ", ")
      (display gc2)   (display "\n")
      (display "racket time (cpu, real, gc): ")
      (display cpu3)  (display ", ")
      (display real3) (display ", ")
      (display gc3)   (display "\n"))))

(test)

;;;;;PODSUMOWANIE
; 
;    Przetestujemy czas działania oryginalnego i zmodyfikowanego interpretera w porównaniu z czasem dziania równoważnych programów w Racketcie. Testy przeprowadzimy na trzech krótich programach: liczeniu sumy liczb z podanego zakresu, wyznaczanie nwd dwóch liczb i liczenie n-tej liczby Fibbonaciego.
;
;    W celu przeprowadzenia wnioskowanie zamieszczam (przykładowe) dane powstałe w wyniku przeprowadzenia testów (program uruchomiony z poziomu terminala):

;liczenie sumy liczb od 1 do 1000:
;without opt  time (cpu, real, gc): 2, 2, 0
;with opt time (cpu, real, gc): 2, 2, 0
;racket time (cpu, real, gc): 0, 0, 0
;
;liczenie sumy liczb od 1 do 1000000:
;without opt  time (cpu, real, gc): 947, 946, 19
;with opt time (cpu, real, gc): 904, 903, 7
;racket time (cpu, real, gc): 3, 3, 0
;
;liczenie NWD liczb 1 1000:
;without opt  time (cpu, real, gc): 1, 0, 0
;with opt time (cpu, real, gc): 1, 1, 0
;racket time (cpu, real, gc): 0, 0, 0
;
;liczenie NWD liczb 1 1000000:
;without opt  time (cpu, real, gc): 733, 733, 8
;with opt time (cpu, real, gc): 723, 722, 5
;racket time (cpu, real, gc): 2, 3, 0
;
;liczenie 1000-tej liczby fib:
;without opt  time (cpu, real, gc): 1, 1, 0
;with opt time (cpu, real, gc): 1, 1, 0
;racket time (cpu, real, gc): 0, 0, 0
;
;liczenie 10000-tej liczby fib:
;without opt  time (cpu, real, gc): 10, 10, 0
;with opt time (cpu, real, gc): 10, 9, 0
;racket time (cpu, real, gc): 1, 1, 0
;
;liczenie 1000000-tej liczby fib:
;without opt  time (cpu, real, gc): 13504, 13490, 1281
;with opt time (cpu, real, gc): 12400, 12401, 979
;racket time (cpu, real, gc): 11357, 11368, 971


;    Jak widać za każdym razem wersja z optymalizacją jest lepsza lub ewentualnie na tym samym poziomie co wersja bez. Oba interpretery są oczywiście gorsze niż programy w Racketcie, co widać na duzych danych (oprócz ostatniego testu gdzie czasy dziiałania sa zblżone).
;
;    Jeśli wersja z optymalizacją jest lepsza tak naprawdę niedużo - około 2-5%. Jednak widać że czym większe dane, tym zoptymalizowana wersja się bardziej opłaca. Jest to związane z wykonywaniem "przypisań" z każdym obrotem pętli w programach. Tzn. czym większe dane tym więcej przypisań. Wynika to z tego że nasza optymalizacja wpływa na env-update który właśnie wywoływany jest przez przypisanie. Czyli czym wiecej przypisań w naszym programie tym wersja z optymalizacją będzie się bardziej opłacała.
;    Mimo małego wpływu jestem za wprowadzeniem optymalizacji. Nie była trudna do implementacji, z jej powodu kod nie wydłużył się znacząco ani nie stał się bardziej skomplikowany. Jest to mała zmiana z punktu widzenia programisty oraz jak widać z testów, mała zmiana z punktu widzenia wydajnościowego. Jednak to z małych zmian składaja się większe zmiany więc moim zdaniem optymalizacja się opłaca. (Szczegółnie jak będziemy mieć przypadek opisany szerzej wyżej - dużo przypisań lub przypisania zależne od wielkości danych z dużymi danymi)
;;;;;
