
#lang typed/racket


;;cwiczenie1
(: prefixes (All [a] (-> (Listof a) (Listof (Listof a)))))
(define (prefixes xs)
  (if (null? xs)
      null
      (cons (list (car xs))
            (map (lambda ([ys : (Listof a)]) (cons (car xs) ys))
                 (prefixes (cdr xs))))))

;;cwiczenie2
(struct vector2 ([x : Real] [y : Real]) #:transparent)
(struct vector3 ([x : Real] [y : Real] [z : Real]) #:transparent)

(define-type Vector (U vector2 vector3))

(define-predicate vector? Vector)

(: vector-length (-> Vector Number))
(define (vector-length v1)
  (if (vector2? v1)
      (sqrt (+ (* (vector2-x v1) (vector2-x v1)) (* (vector2-y v1) (vector2-y v1))))
      (sqrt (+ (* (vector3-x v1) (vector3-x v1)) (* (vector3-y v1) (vector3-y v1)) (* (vector3-z v1) (vector3-z v1))))))

(: vector-length2 (-> Vector Number))
(define (vector-length2 v1)
  (match v1
    [(vector2 x y) (sqrt (+ (* x x) (* y y)))]
    [(vector3 x y z) (sqrt (+ (* x x) (* y y) (* z z)))]))


;;cwiczenie3
;( parametric->/c [a b] (- > (- > a b ) ( listof a ) ( listof b ) ) )
;( parametric->/c [a] (-> (-> a a) (listof a) (listof a)))
(: map (All (a b) (-> (-> a b) (Listof a) (Listof b))))
(define (map f xs)
  (if (null? xs)
      null
      (cons (f (car xs)) (map f (cdr xs)))))

(: map2 (All (a) (-> (-> a a) (Listof a) (Listof a))))
(define (map2 f xs)
  (if (null? xs)
      null
      (cons (f (car xs)) (map f (cdr xs)))))

;;;cwiczenie4
;(struct (a b) node ([v : a] [xs : (Listof b)]) #:transparent)
;(struct leaf () #:transparent)
;
;(define-type (Tree-Rose a) (U leaf (node a (Tree-Rose a))))
;
;(define-predicate tree? (Tree-Rose Any))
;
;(: map3 (All (a b) (-> (-> (Tree-Rose a) (Listof a)) (Listof a) )))
;(define (map3 f xs)
;  (if (null? xs)
;      null
;      (cons (f (car xs)) (map3 f (cdr xs)))))
;(: appmap (All (a) (-> (-> (Tree-Rose a) (Listof a)) (Listof a)(Listof a))))
;(define (appmap f xs)
;  (if (null?  xs)
;      null
;      (cons (map3 f (car xs)) (appmap f (cdr xs)))))
; 
;(: print-tree (All (a) (-> (Tree-Rose a) (Listof a))))
;(define (print-tree t)
;  (if (leaf? t)
;      null
;      (cons (node-v t) (appmap print-tree (node-xs t)))))

;;;cwiczenie5
;(struct variable (x)        #:transparent)
;(struct const    (val)      #:transparent)
;(struct op       (symb l r) #:transparent)
;(struct let-expr (x e1 e2)  #:transparent)
;(struct if-expr  (b t e)    #:transparent)
;  
;(define (lookup x xs)
;  (cond
;    [(null? xs)
;     (error x "unknown identifier :(")]
;    [(eq? (caar xs) x) (cadar xs)]
;    [else (lookup x (cdr xs))]))
;
;(define (op-to-proc x)
;  (lookup x `(
;              (+ ,+)
;              (* ,*)
;              (- ,-)
;              (/ ,/)
;              (> ,>)
;              (>= ,>=)
;              (< ,<)
;              (<= ,<=)
;              (= ,=)
;              )))
;
;
;(define (env-empty) null)
;(define env-lookup lookup)
;(define (env-add x v env) (cons (list x v) env))
;
;
;(define (eval e env)
;  (match e
;    [(const n) n]
;    [(op s l r)
;     ((op-to-proc s) (eval l env)
;                     (eval r env))]
;    [(let-expr x e1 e2)
;     (let ((v1 (eval e1 env)))
;       (eval e2 (env-add x v1 env)))]
;    [(variable x) (env-lookup x env)]
;    [(if-expr b t e) (if (eval b env)
;                         (eval t env)
;                         (eval e env))]))
;
;(define (run e)
;  (eval e (env-empty)))
;
;
