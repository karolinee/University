#lang racket

(require rackunit)

(define (merge xs ys)
  (cond [(null? xs) ys]
        [(null? ys) xs]
        [(< (car xs) (car ys)) (cons (car xs) (merge (cdr xs) ys))]
        [else (cons (car ys) (merge xs (cdr ys)))]))

(define (split xs)
  (define (iter first second k)
    (if (= k 0)
        (cons first second)
        (iter (append first (list (car second))) (cdr second) (- k 1))))
  (iter null xs (ceiling (/ (length xs) 2))))

(define (mergesort xs)
  (if (or (null? xs) (null? (cdr xs)))
      xs
      (let ((s (split xs)))
        (merge (mergesort (car s)) (mergesort (cdr s))))))

(define mergesort-tests
  (test-suite
   "Testowanie implementacji sortowania przez scalanie (mergesort)"
   (test-case
    "Procedura split"
    (check-equal? (split null) (cons null null) "Lista pusta")
    (check-equal? (split (list 1)) (cons (list 1) null) "Lista z jednym elementem")
    (check-equal? (split (list 1 2)) (cons (list 1) (list 2)) "Lista z parzysta liczba elementow")
    (check-equal? (split (list 1 2 3)) (cons (list 1 2) (list 3)) "Lista z nieparzystą liczbą elementów"))

   (test-case
    "Procedura merge"
    (check-equal? (merge null null) null "Dwie listy puste")
    (check-equal? (merge null (list 1)) (list 1) "Piersza lista pusta")
    (check-equal? (merge (list 1) null) (list 1) "Druga lista pusta")
    (check-equal? (merge (list 1) (list 1)) (list 1 1) "Dwie takie same listy")
    (check-equal? (merge (list 1 4 6 6) (list 1 3 5 7)) (list 1 1 3 4 5 6 6 7) "Dwie różne listy z powtarzającymi się elementami"))

   (test-case
    "Procedura mergesort"
    (check-equal? (mergesort null) null "Sortowanie listy pustej")
    (check-equal? (mergesort (list 1)) (list 1) "Sortowanie listy jednoelementowej")
    (check-equal? (mergesort (list 1 3 5 7)) (list 1 3 5 7) "Sortowanie listy posortowanej")
    (check-equal? (mergesort (list 8 6 5 4 1)) (list 1 4 5 6 8) "sortowanie listy odwrotnie posortowanej")
    (check-equal? (mergesort (list 1 5 1 3 5)) (list 1 1 3 5 5) "Sortowanie listy nieposortowanej z powtarzającymi się elementami"))))
 

(require rackunit/text-ui)
(run-test mergesort-tests)


