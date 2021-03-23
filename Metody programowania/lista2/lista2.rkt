#lang racket

;; kod z wykladu
(define (inc n)
  (+ n 1))

(define (square n)
  (* n n))

(define (cube n)
  (* n n n))

(define (identity x)
  x)

(define (average x y)
  (/ (+ x y) 2))


(define (sum val next start end)
  (if (> start end)
      0
      (+ (val start)
         (sum val next (next start) end))))

;;cwiczenie 2
(define (compose f g)
  (lambda (x) (f (g x))))

;;cwiczenie 3
(define (repeated p n)
  (if (= n 0)
      identity
      (compose p (repeated p (- n 1)))))

;;cwiczenie 4
(define (product val next start end)
  (if (> start end)
      1
      (* (val start) (product val next (next start) end))))

(define (term x) (/ (* x (+ x 2)) (square (+ x 1))))
(define (inc2 x) (+ x 2))

(define pi (* 4.0 (product term inc2 2 100))) 

;;cwiczenie 5
(define (acc combiner null-value term a next b)
  (if (> a b)
    null-value
    (combiner (term a) (acc combiner null-value term (next a) next b ))))

(define (acc-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))


;;cwiczenie 6
(define (num k)
  1)
(define (den k)
  1)

(define (cont-frac num den k)
 (if (= k 0)
    0
    (/ (cont-frac num den (k-1)))

(define (cont-frac-iter num den k)
  (define (iter k result)
    (if (= k 0)
        result
        (/ (num k) (+ (den k) (iter (- k 1) result)))))
  (iter k 0))




