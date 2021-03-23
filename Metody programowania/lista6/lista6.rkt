#lang racket

;;;;;;;;;;;;;;;;;;;;;
;zadanie 2
;;;;;;;;;;;;;;;;;;;;;
(struct node (v l r) #:transparent)
(struct leaf () #:transparent)

;; predykat: czy dana wartość jest drzewem binarnym?

(define (tree? t)
  (match t
    [(leaf) true]
    ; wzorzec _ dopasowuje się do każdej wartości
    [(node _ l r) (and (tree? l) (tree? r))]
    ; inaczej niż w (cond ...), jeśli żaden wzorzec się nie dopasował, match kończy się błędem
    [_ false]))

;; przykładowe użycie dopasowania wzorca

(define (insert-bst v t)
  (match t
    [(leaf) (node v (leaf) (leaf))]
    [(node w l r)
     (if (< v w)
         (node w (insert-bst v l) r)
         (node w l (insert-bst v r)))]))

(define (paths t)
  (match t
    [(leaf) (list (list '*))]
    [(node v r l) (map (lambda (x) (cons v x))
                       (append (paths l) (paths r)))]))


;;;;;;;;;;;;;;;;;;;;;
;zadanie 3
;;;;;;;;;;;;;;;;;;;;;

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

(define (more e)
  (define (count t)
    (match t
      [(const v) 0]
      [(op '+ l r) (+ (count l) (count r) 1)]
      [(op '* l r) (+ (count l) (count r) -1)]))
  (let ((wyn (count e)))
        (cond [(> 0 wyn) '*]
              [(< 0 wyn) '+]
              [else '=])))



;;;;;;;;;;;;;;;;;;;;
;cwiczenie 4
;;;;;;;;;;;;;;;;;;;
(struct doc (title author chapters) #:transparent)
(struct chapter (title elements) #:transparent)
(struct subchapter (title elements) #:transparent)
(struct paragraph (str) #:transparent)

(define (text? t)
  (match t
    [(paragraph s) (string? s)]
    [(chapter t e) (and (string? t)
                        (andmap text? e))]
    [(doc t a ch)  (and (string? t)
                        (string? a)
                        (andmap chapter? ch)
                        (andmap text? ch))]))


(define (text->HTML t)
  (define (list-of-chapters ys)
    (defien (chapter->HTML c)
      (match e
        [(chapter t e) (string-append "<h1>"
                                   t
                                  "</h1>"
                                   (list-of-chapters e))]
        [(subchapter t e) (string-append "<h2>"
                                          t
                                         "</h2>"
                                         (list-of-chapters e))]
        [(paragraph s) s]))
    (cond [(null? ys) ""]
          
                                     

  (string-append "<html>"
                  "<head>"
                   "<title>" (doc-title t)
                   "</title>"
                  "</head>"
                  "<body>"
                  (list-of-chapters t)
                  "</body>"
                 "</html>"))
                   
  
                              
    
  