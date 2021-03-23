#lang racket

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;LISTA 4;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;
;;KOD Z WYKŁADU
;;;;;;;;;;;;;;;
(define (tagged-list? len sym x)
  (and (list? x)
       (= (length x) len)
       (eq? (first x) sym)))

;; drzewa binarne etykietowane w wierzchołkach wewnętrznych
(define leaf 'leaf)

(define (leaf? x)
  (eq? x 'leaf))

(define (node e l r)
  (list 'node e l r))

(define (node? x)
  (tagged-list? 4 'node x))

(define (node-elem x)
  (second x))

(define (node-left x)
  (third x))

(define (node-right x)
  (fourth x))

(define (tree? x)
  (or (leaf? x)
      (and (node? x)
           (tree? (node-left  x))
           (tree? (node-right x)))))

;; operacje na drzewach BST
(define (find x t)
  (cond
    [(leaf? t)            false]
    [(= (node-elem t) x)  true]
    [(> (node-elem t) x)  (find x (node-left t))]
    [(< (node-elem t) x)  (find x (node-right t))]))

(define (insert x t)
  (cond
    [(leaf? t)            (node x leaf leaf)]
    [(= (node-elem t) x)  t]
    [(> (node-elem t) x)  (node (node-elem t)
                                (insert x (node-left t))
                                (node-right t))]
    [(< (node-elem t) x)  (node (node-elem t)
                                (node-left t)
                                (insert x (node-right t)))]))

(define empty leaf)
;; przykładowe własności:
;; (find x (insert x t)) == true
;; (find x t)            == (find x (insert y t)) jeśli (not (= x y))
;; (find x empty)        == false


;;;;;;;;;;
;;ZADANIE1
;;;;;;;;;;
(define (append . dd)
  (if (null? dd)
      null
      (if (null? (car dd))
          (apply append (cdr dd))
          (cons (car (car dd)) (apply append (cons (cdr (car dd)) (cdr dd)))))))

;;;;;;;;;;
;;ZADANIE2
;;;;;;;;;;

(define (btree? t)
  (or (eq? t 'leaf)
      (and (tagged-list? 4 'node t)
           (btree? (third t))
           (btree? (fourth t)))))

(define (mirror t)
  (if (leaf? t)
      t
      (node (node-elem t) (mirror (node-right t)) (mirror (node-left))))) 


;;;;;;;;;;
;;ZADANIE3
;;;;;;;;;;

(define (flatten-bad t)
  (if (leaf? t)
      '()
      (append (flatten (node-left t)) (list (node-elem t)) (flatten (node-right t)))))

(define (flatten tr)
  (define (flatten-aux t ls)
    (if (leaf? t)
        ls
        (flatten-aux (node-left t) (cons (node-elem t) (flatten-aux (node-right t) ls)))))
  (flatten-aux tr null))

(define tree '(node a (node b (node c leaf leaf) leaf) (node d leaf leaf)))

;;;;;;;;;;
;;ZADANIE4
;;;;;;;;;;
(define (treesort xs t)
  (if (null? xs)
      (flatten t)
      (treesort (cdr xs) (insert (car xs) t))))


;;;;;;;;;;
;;ZADANIE6
;;;;;;;;;;
(define (concatMap f xs)
  (if (null? xs)
      null
      (append (f (car xs)) (concatMap f (cdr xs)))))


(define (from-to s e)
  (if (= s e)
      (list s)
      (cons s (from-to (+ s 1) e))))

(define (queens board-size)
  ;; Return the representation of a board with 0 queens inserted
  (define (empty-board)
    (define (iter krok ls)
      (if (not(< krok board-size))
          ls
          (item (+ krok 1) (cons -1 ls))))
      (iter 0 null))
  ;; Return the representation of a board with a new queen at
  ;; (row, col) added to the partial representation `rest'
  (define (adjoin-position row col rest)
    (if (= col 0)
        (cons row (cdr rest))
        (cons (car rest) (addjoin-position row (- col 1) (cdr rest)))))
        
  ;; Return true if the queen in k-th column does not attack any of
  ;; the others
  (define (safe? k positions)
    (define (rzad-k kork ys)
      (if (= krok 0)
          (car ys)
          (rzad (- krok 1) (cdr ys))))
    (define (sprawdz n)
      (define (iter aktualnaK)
        (if (= (rzad-k aktualnaK ls) n)
            false
            (if (= (abs (- aktualnaK k) (abs (- (rzad-k aktualneK ls) n))))
                false
                true)))))
        
  ;sprawdzenie czy akt k to k
  ;sprawdzenie czy nie poza tablice
  
  ;; Return a list of all possible solutions for k first columns
  (define (queen-cols k)
    (if (= k 0)
        (list (empty-board))
        (filter
         (lambda (positions) (safe? k positions))
         (concatMap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (from-to 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))