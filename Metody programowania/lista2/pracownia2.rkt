#lang racket
;Karolina Jeziorska

(define (good-enough? x y)
  (< (abs (- x y)) 0.000001))

(define (average x y)
  (/ (+ x y) 2))


(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (= n 0)
      identity
      (compose f (repeated f (- n 1)))))


(define (fixed-point f s)
  (define (iter k)
    (let ((new-k (f k)))
      (if (good-enough? k new-k)
          k
          (iter new-k))))
  (iter s))


(define (nth-root n x)
  (define (f y)
    (/ x (expt y (- n 1))))  
  (fixed-point ((repeated average-damp (floor (log n 2))) f) 1.0))

;;TESTY
;;1 krotne wytlumienienie pozwala na oblicznie pierwiastka 2 i 3 stopnia
(nth-root 2 4)
(nth-root 3 8) 
;;przy liczeniu pierwiastka 4 stopnia funkcja zawodzi
(nth-root 4 16)

;;2 krotne wytlumienie pozwala obliczycz pierwiastki az do 7 stopnia
(nth-root 4 16)
(nth-root 5 32)
(nth-root 6 64)
(nth-root 7 128)
;;przy liczeniu pierwiastka 8 stopnia funkcja zawodzi
(nth-root 8 256)

;;3 krotne wytlumienie pozwala obliczycz pierwiastki az do 15 stopnia
(nth-root 8 256)
(nth-root 10 1024)
(nth-root 15 32768)
;;przy liczeniu pierwiastka 16 stopnia funkcja zawodzi
(nth-root 16 65536)

;;WNIOSEK
;;Żeby obliczyć pierwiastek n-tego stopnia potrzeba log2(n) wytłumień

(nth-root 3 -8)
(nth-root 50 544398259458362969883825649235)
