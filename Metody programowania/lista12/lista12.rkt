#lang racket

;;zadanie 1
(define (dist x y)
  (abs (- x y)))
(define (good-enough x y)
  (< (dist x y) 0.001))
(define (square x)
  (* x x))
(define (average x y)
  (/ (+ x y) 2))

(define (is-sqrt?/c x)
  (lambda (y) (good-enough (square y) x)))
(define/contract (sqrt x)
  (->i ([l (and/c real? positive?)])
       [result (l) (and/c positive?
                          (is-sqrt?/c l))])
  ;; lokalne definicje
  ;; poprawienie przybliżenia pierwiastka z x
  (define (improve approx)
    (average (/ x approx) approx))
  ;; nazwy predykatów zwyczajowo kończymy znakiem zapytania
  (define (good-enough? approx)
    (< (dist x (square approx)) 0.0001))
  ;; główna procedura znajdująca rozwiązanie
  (define (iter approx)
    (cond
      [(good-enough? approx) approx]
      [else                  (iter (improve approx))]))
  
  (iter 1.0))


;;zadanie 2
(define filter/c
  (parametric->/c [a]
                  (-> (-> a boolean?) (listof a) (listof a))))

(define filteri/c
  (parametric->/c [a]
                  (->i ([f (-> a boolean?)]
                        [xs (listof a)])
                       [result (f xs) (lambda (ys) (andmap f ys))])))

;;zadanie 3
(define-signature monoid^
  ((contracted
    [elem?      (-> any/c boolean?)]
    [neutral    elem?]
    [oper       (-> elem? elem? elem?)])))
    

(define-unit monoid-int@
  (import)
  (export monoid^)

  (define (elem? x)
    (integer? x))

  (define neutral 0)

  (define (oper x y)
    (+ x y)))


(define-unit monoid-list@
  (import)
  (export monoid^)

  (define (elem? x)
    (list? x))

  (define neutral '())

  (define (oper x y)
    (append x y)))

;;zadanie 4
(require quickcheck)
(define-values/invoke-unit/infer monoid-list@)

;(quickcheck
; (property ([x arbitrary-integer])
;           (==> (elem? x)
;                (and (eq? x (oper x neutral)) (eq? x (oper neutral x))))))
;
;(quickcheck
; (property ([x arbitrary-integer]
;            [y arbitrary-integer]
;            [z arbitrary-integer])
;           (==> (and (elem? x) (elem? y) (elem? z))
;                (eq? (oper x (oper y z)) (oper (oper x y) z)))))

(quickcheck
 (property ([x (arbitrary-list arbitrary-symbol)])
           (==> (elem? x)
                (and (equal? x (oper x neutral)) (equal? x (oper neutral x))))))

(quickcheck
 (property ([x (arbitrary-list arbitrary-symbol)]
            [y (arbitrary-list arbitrary-symbol)]
            [z (arbitrary-list arbitrary-symbol)])
           (==> (and (elem? x) (elem? y) (elem? z))
                (equal? (oper x (oper y z)) (oper (oper x y) z)))))


;;zadanie 5
(define-signature set^
  ((contracted
    [set?         (-> any/c boolean?)]
    [set-empty?   (-> set? boolean?)]
    [set-empty    set-empty?]
    [set-member   (-> set? integer? boolean?)]
    [singleton    (-> integer? set?)]
    [set-sum      (-> set? set? set?)]
    [set-iloczyn  (-> set? set? set?)])))

(define-unit set-list@
  (import)
  (export set^)

  (define (set? x)
    (and (list? x)
         ((listof integer?) x)))

  (define (set-empty? s)
    (null? s))
  
  (define set-empty '())

  

  (define (set-member s x)
    (if (member x s)
        #t
        #f))

  (define (singleton x) (list x))

  (define (set-sum s1 s2)
    (remove-duplicates (append s1 s2)))

  (define (remove-duplicates xs)
    (if (null? xs)
        null
        (if (member (car xs) (cdr xs))
            (remove-duplicates (cdr xs))
            (cons (car xs) (remove-duplicates (cdr xs))))))

  (define (set-iloczyn s1 s2)
    (define (aux s1)
      (if (null? s1)
          null
          (if (member (car s1) s2)
              (cons (car s1) (aux (cdr s1)))
              (aux (cdr s1)))))
    (remove-duplicates (aux s1))))
                     
(define-values/invoke-unit/infer set-list@)


;;zadanie 6

(define (contains xs ys)
  (andmap (lambda (x) (set-member ys x)) xs))
(define/contract (the-same? xs ys)
  (-> list? list? boolean?)
  (and (contains xs ys) (contains ys xs)))

(quickcheck
 (property ([x arbitrary-integer])
           (not (set-member set-empty x))))


(quickcheck
 (property ()
           (set-empty? set-empty)))


(quickcheck
 (property ([x arbitrary-integer])
           (set-member (singleton x) x)))

(quickcheck
 (property ([xs (arbitrary-list arbitrary-integer)]
            [ys (arbitrary-list arbitrary-integer)])
           (andmap (lambda (l) (or (set-member xs l) (set-member ys l))) (set-sum xs ys))))

(quickcheck
 (property ([xs (arbitrary-list arbitrary-integer)]
            [ys (arbitrary-list arbitrary-integer)])
           (andmap (lambda (l) (and (set-member xs l) (set-member ys l))) (set-iloczyn xs ys))))

(quickcheck
 (property ([xs (arbitrary-list arbitrary-integer)]
            [ys (arbitrary-list arbitrary-integer)]
            [zs (arbitrary-list arbitrary-integer)])
           (the-same? (set-sum xs (set-iloczyn ys zs)) (set-iloczyn (set-sum xs ys) (set-sum xs zs)))))

(quickcheck
 (property ([xs (arbitrary-list arbitrary-integer)]
            [ys (arbitrary-list arbitrary-integer)]
            [zs (arbitrary-list arbitrary-integer)])
           (the-same? (set-iloczyn xs (set-sum ys zs)) (set-sum (set-iloczyn xs ys) (set-iloczyn xs zs)))))


