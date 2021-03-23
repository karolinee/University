#lang racket

;; definicja wyrażeń arytmetycznych

(struct const (val) #:transparent)
(struct op (symb l r) #:transparent)

(define (expr? e)
  (match e
    [(const n) (number? n)]
    [(op s l r) (and (member s '(+ *))
                     (expr? l)
                     (expr? r))]
    [_ false]))

;; przykładowe wyrażenie

(define e1 (op '* (op '+ (const 2) (const 2))
                  (const 2)))

;; ewaluator wyrażeń arytmetycznych

(define (eval e)
  (match e
    [(const n) n]
    [(op '+ l r) (+ (eval l) (eval r))]
    [(op '* l r) (* (eval l) (eval r))]))

;; kompilator wyrażeń arytmetycznych do odwrotnej notacji polskiej

(define (to-rpn e)
  (match e
    [(const n) (list n)]
    [(op s l r) (append (to-rpn l)
                        (to-rpn r)
                        (list s))]))


(define (eval-rpn e)
  (define (aux e xs)
    (if (null? e)
        xs
        (let ((w (car e)))
              (cond [(eq? '+ w)(aux (cdr e) (cons (+ (car xs) (car (cdr xs))) (cddr xs)))]
                    [(eq? '* w)(aux (cdr e) (cons (* (car xs) (car (cdr xs))) (cddr xs)))]
                    [else (aux (cdr e) (cons w xs))]))))
  (let ((wyn (aux e null)))
    (if (= 1 (length wyn))
        (car wyn)
        (error "bledne wyrazenie"))))
