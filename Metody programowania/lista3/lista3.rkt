#lang racket

;;;ctrl+i przed zapisaniem plikow!
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;cwiczenie 1
;;;;;;;;;;;;;;;;;;;;;;;;;;

;;punkty
(define (make-point x y)
  (cons x y))
(define (point? p)
  (and (pair? p)
       (number? (car p))
       (number? (cdr p))))
(define (point-x p)
  (car p))
(define (point-y p)
  (cdr p))

;;wektory
(define (make-vect x y)
  (cons x y))
(define (vect? v)
  (and (pair? v)
       (and (pair? (car v))(point? (car v)))
       (and (pair? (cdr v))(point? (cdr v)))))
(define (vect-begin v)
  (car v))
(define (vect-end v)
  (cdr v))



;;funkcje
(define (vect-length v)
  (let ([a (- (point-x (vect-begin v)) (point-x (vect-end v)))]
        [b (- (point-y (vect-begin v)) (point-y (vect-end v)))])
    (expt (+ (expt a 2) (expt b 2)) (/ 1 2))))

(define (vect-scale v k)
  (make-vect (vect-begin v) (make-point (* k (point-x (vect-end)))
                                        (* k (point-y (vect-end))))))

(define (square x)
  (* x x))

(define (vect-translate v p)
  (let ([dx (- (point-x p) (point-x (vect-begin v)))]
        [dy (- (point-y p) (point-y (vect-begin v)))])
    (make-vect p (make-point (+ (point-x (vect-end v)) dx) (+ (point-y (vect-end v)) dy)))))

(define (display-point p)
  (display "(")
  (display (point-x p))
  (display ", ")
  (display (point-y  p))
  (display ")"))
(define (display-vect v)
  (display "[")
  (display (point-x v))
  (display ", ")
  (display (point-y v))
  (display "]"))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;cwiczenie 2
;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (make-vect2 p k d)
  (cons p (cons k d)))
(define (vect?2 v)
  (and (pair? v)
       (pair? (cdr v))
       (point? (car v))
       (number? (car (cdr v)))
       (or (= 0 (car (cdr v)) (> (car (cdr v)) 0)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;cwiczenie 3
;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (reverse xs)
  (if (null? xs)
      null
      (append (reverse (cdr xs)) (list (car xs)))))

(define (reverse-iter xs)
  (define (iter rt end)
    (if (null? rt)
        end
        (iter (cdr rt) (cons (cdr rt) end))))
  (iter xs null))
  
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;cwiczenie 4
;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (insert cmp L1 n)
  (cond
    ((null? n) (list L1))
    ((null? L1) (cons n L1))
    ((cmp n (car L1)) (cons n L1))
    (else (cons (car L1) (insert cmp (cdr L1) n)))
   )
)

;Definition of insertionSort: sorts a list based on a recursive insertion sort
;L1: a list, cmp: < or >
(define (insertionSort L1 cmp)
  (cond
    ((null? L1) L1)
    (else (insert cmp (car L1) (insertionSort(cdr L1) cmp)))
  )
)
  
       