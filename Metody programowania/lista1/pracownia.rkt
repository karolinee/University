#lang racket

(define (average3 x y z)
  (/ (+ x y z) 3))

(define (square x)
  (* x x))

(define (cube x)
  (* x x x))

(define (dist x y)
  (abs (- x y)))

(define (abs x)
  (if (< x 0)
      (- x)
      x))

(define (cube-root x)
  (define (improve guess)
    (average3 (/ x (square guess)) guess guess))
  (define (good-enough? guess)
    (< (dist x (cube guess)) 0.0001))
  (define (iter guess)
    (if (good-enough? guess)
        guess
        (iter (improve guess))))
  (iter 1.0))

;;przykłady testowe
(cube-root 2)
(cube-root 1)
(cube-root -1)
(cube-root 8)
(cube-root -8)
(cube-root 64)
(cube-root -125)
(cube-root 0.125)