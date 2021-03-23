#lang racket
;Karolina Jeziorska

(define (abs x)
  (if (< x 0)
      (- x)
      x))

(define (square x) (* x x))

(define (good-enough? x y)
  (< (abs (- x y)) 0.000001))



(define (con-frac-iter num den)
  
  (define (calc-a k)
    (define (iter i previous previous-two)
      (if (= k i)
           previous
           (iter (+ i 1) (+ (* (den (+ i 1)) previous) (* (num (+ i 1)) previous-two)) previous)))
    (iter 0 0 1))
  
  (define (calc-b k)
    (define (iter i previous previous-two)
      (if (= k i)
           previous
           (iter (+ i 1) (+ (* (den (+ i 1)) previous) (* (num (+ i 1)) previous-two)) previous)))
    (iter 0 1 0))
  
 (define (iter n result)
    (let ([new-result (/ (calc-a n) (calc-b n))])
     (if (good-enough? result new-result)
       result
       (iter (+ n 1) new-result))))
 (iter 1 0))

;;TESTY
(define pi
  (+ 3 (con-frac-iter (lambda (i) (square (- (* 2 i) 1)))
                  (lambda (i) 6.0))))
pi

(define fi
  (con-frac-iter (lambda (i) 1.0 ) (lambda (i) 1.0)))
fi

(define (atan-cf x)
  (con-frac-iter (lambda (i) (if (= i 1) x (square (* (- i 1) x)))) (lambda (i) (- (* 2.0 i) 1))))

(atan-cf 1)
(atan 1)
(atan-cf 3)
(atan 3)
