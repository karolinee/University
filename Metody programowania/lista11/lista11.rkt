#lang racket

;zadanie 1
(define/contract (sufixes xs)
  (parametric->/c [a] (-> (listof a) (listof (listof a))))
  (if (null? xs)
      (list null)
      (cons xs (sufixes (cdr xs)))))

;zadanie 2
(define/contract (sublists xs)
  (parametric->/c [a] (->(listof a) (listof (listof a))))
  (if (null? xs)
      (list null)
      (append-map
       (lambda (ys) (list (cons (car xs) ys) ys))
       (sublists (cdr xs)))))

;zadanie 3
(define/contract (foo x y)
  (parametric->/c [a b] (-> a b a))
  x)

(define/contract (foo2 f g x)
  (parametric->/c [a b c] (-> (-> a b c) (-> a b) a c))
  (f x (g x)))

(define (foo3 f g)  
  (parametric->/c [a b c] (-> (-> b c) (-> a b) (-> a c)))
  (lambda (x) (f (g x))))

(define/contract (foo4 f)
  (parametric->/c [a] (-> (-> (-> a a) a) a))
  (f (lambda (x) x)))

;zadanie 4
(define/contract (foo5 x)
  (parametric->/c [a b] (-> a b))
  (error "bad contract"))



;zadanie5
(define/contract (map f xs)
 (parametric->/c [a b] ((-> a b) (listof a) (listof b)))
  (if (null? xs)
      xs
      (cons (f (car xs)) (map f (cdr xs)))))

(define/contract (foldl f xs e)
 (parametric->/c [a b] ((-> b a b) b (listof a) b))
  (if (null? xs)
      e
      (f (foldl f (cdr xs e)))))

(define/contract (foldl-map f a xs)
  (parametric->/c [a b c] (-> (-> a b (cons/c c b)) b (listof a) (cons/c (listof c) b)))
  (define (it a xs ys)
    (if (null? xs)
        (cons (reverse ys) a)
        (let [(p (f (car xs) a))]
          (it (cdr p) (cdr xs) (cons (car p) ys )))))
    (it a xs null))


;zadanie6


;; definicja wyrażeń z let-wyrażeniami

(struct const    (val)      #:transparent)
(struct op       (symb l r) #:transparent)
(struct let-expr (x e1 e2)  #:transparent)
(struct variable (x)        #:transparent)

(define (expr? e)
  (-> expr/c boolean?)
  (match e
    [(variable s)       (symbol? s)]
    [(const n)          (number? n)]
    [(op s l r)         (and (member s '(+ *))
                             (expr? l)
                             (expr? r))]
    [(let-expr x e1 e2) (and (symbol? x)
                             (expr? e1)
                             (expr? e2))]
    [_                  false]))

;; podstawienie wartości (= wyniku ewaluacji wyrażenia) jako stałej w wyrażeniu

(define (subst x v e)
  (-> symbol? expr/c expr/c expr/c)
  (match e
    [(op s l r)   (op s (subst x v l)
                        (subst x v r))]
    [(const n)    (const n)]
    [(variable y) (if (eq? x y)
                      (const v)
                      (variable y))]
    [(let-expr y e1 e2)
     (if (eq? x y)
         (let-expr y
                   (subst x v e1)
                   e2)
         (let-expr y
                   (subst x v e1)
                   (subst x v e2)))]))

;; (gorliwa) ewaluacja wyrażenia w modelu podstawieniowym

(define (eval e)
  (-> expr/c real?)
  (match e
    [(const n)    n]
    [(op '+ l r)  (+ (eval l) (eval r))]
    [(op '* l r)  (* (eval l) (eval r))]
    [(let-expr x e1 e2)
     (eval (subst x (eval e1) e2))]
    [(variable n) (error n "cannot reference an identifier before its definition ;)")]))

(define expr/c
  (flat-rec-contract expr
                     (struct/c variable symbol?)
                     (struct/c const number?)
                     (struct/c op symbol? expr expr)
                     (struct/c let-expr symbol? expr expr)))