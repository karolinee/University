#lang racket
(define (square x) (* x x))

(define (foo x y z) (if (> x y) (+ (square x)
                                   (if (> y z) (square y) (square z)))
                        (+ (square y) (if (> x z ) (square x) (square z)))))

(define (power-close-to b n)
  (define (warunek e) (> (expt b e) n))
  (define (iter e)
    (if (warunek e)
        e
        (iter (+ 1 e))))
  (iter 1.0))