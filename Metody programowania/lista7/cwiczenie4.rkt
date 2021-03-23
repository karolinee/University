#lang racket

(struct const (val) #:transparent)
(struct op (symb l r) #:transparent)
(struct variable () #:transparent)

(define (expr? e)
  (match e
    [(variable) true]
    [(const n)  (number? n)]
    [(op s l r) (and (member s '(+ *))
                     (expr? l)
                     (expr? r))]
    [_          false]))

;; przykładowe wyrażenie

(define f (op '* (op '* (variable) (variable))
              (variable)))

;; pochodna funkcji

(define (∂ f)
  (match f
    [(const n)   (const 0)]
    [(variable)  (const 1)]
    [(op '+ f g) (op '+ (∂ f) (∂ g))]
    [(op '* f g) (op '+ (op '* (∂ f) g)
                     (op '* f (∂ g)))]))

;; przykładowe użycie

(define df (∂ f))
(define ddf (∂ (∂ f)))
(define dddf (∂ (∂ (∂ f))))


(define (simplyfi f)
  (match f
    [(const v) (const v)]
    [(variable) (variable)]
    [(op '+ w1 w2) (let ((w1s (simplyfi w1))
                         (w2s (simplyfi w2)))
                     (cond
                       [(equal? (const 0) w1s) w2s]
                       [(equal? (const 0) w2s) w1s]
                       [(equal? w1s w2s) (op '* (const 2) w1s)]
                       [else (op '+ w1s w2s)]))]
    [(op '* w1 w2) (let ((w1s (simplyfi w1))
                         (w2s (simplyfi w2)))
                     (cond
                       [(or (equal? (const 0) w1s) (equal? (const 0) w2s)) (const 0)]
                       [(equal? (const 1) w1s) w2s]
                       [(equal? (const 1) w2s) w1s]
                       [else (op '+ w1s w2s)]))]))                    
   