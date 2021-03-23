#lang racket


;; sygnatura: grafy
(define-signature graph^
  ((contracted
    [graph        (-> list? (listof edge?) graph?)]
    [graph?       (-> any/c boolean?)]
    [graph-nodes  (-> graph? list?)]
    [graph-edges  (-> graph? (listof edge?))]
    [edge         (-> any/c any/c edge?)]
    [edge?        (-> any/c boolean?)]
    [edge-start   (-> edge? any/c)]
    [edge-end     (-> edge? any/c)]
    [has-node?    (-> graph? any/c boolean?)]
    [outnodes     (-> graph? any/c list?)]
    [remove-node  (-> graph? any/c graph?)]
    )))

;; prosta implementacja grafów
(define-unit simple-graph@
  (import)
  (export graph^)

  (define (graph? g)
    (and (list? g)
         (eq? (length g) 3)
         (eq? (car g) 'graph)))

  (define (edge? e)
    (and (list? e)
         (eq? (length e) 3)
         (eq? (car e) 'edge)))

  (define (graph-nodes g) (cadr g))

  (define (graph-edges g) (caddr g))

  (define (graph n e) (list 'graph n e))

  (define (edge n1 n2) (list 'edge n1 n2))

  (define (edge-start e) (cadr e))

  (define (edge-end e) (caddr e))

  (define (has-node? g n) (not (not (member n (graph-nodes g)))))
  
  (define (outnodes g n)
    (filter-map
     (lambda (e)
       (and (eq? (edge-start e) n)
            (edge-end e)))
     (graph-edges g)))

  (define (remove-node g n)
    (graph
     (remove n (graph-nodes g))
     (filter
      (lambda (e)
        (not (eq? (edge-start e) n)))
      (graph-edges g)))))

;; sygnatura dla struktury danych
(define-signature bag^
  ((contracted
    [bag?       (-> any/c boolean?)]
    [empty-bag  (and/c bag? bag-empty?)]
    [bag-empty? (-> bag? boolean?)]
    [bag-insert (-> bag? any/c (and/c bag? (not/c bag-empty?)))]
    [bag-peek   (-> (and/c bag? (not/c bag-empty?)) any/c)]
    [bag-remove (-> (and/c bag? (not/c bag-empty?)) bag?)])))

;; struktura danych - stos
(define-unit bag-stack@
  (import)
  (export bag^)

  (define (bag? b)
    (list? b))

  (define (bag-empty? b)
    (null? b))

  (define empty-bag null)

  (define (bag-insert b v)
    (cons v b))

  (define (bag-peek b)
    (car b))

  (define (bag-remove b)
    (cdr b))
  )

; struktura danych - kolejka FIFO
; do zaimplementowania przez studentów
(define-unit bag-fifo@
  (import)
  (export bag^)

  (define (bag? b)
    (and (pair? b)
         (list? (car b))
         (list? (cdr b))))

  (define (bag-empty? b)
    (and (null? (car b))
         (null? (cdr b))))

  (define empty-bag (cons '() '()))

  (define (bag-insert b v)
    (cons (cons v (car b)) (cdr b)))
  
  (define (bag-peek b)
    (if (null? (cdr b))
        (bag-peek (cons '() (reverse (car b))))
        (car (cdr b))))

  (define (bag-remove b)
    (if (null? (cdr b))
        (bag-remove (cons '() (reverse (car b))))
        (cons (car b) (cdr (cdr b))))))
  
        
  

;; sygnatura dla przeszukiwania grafu
(define-signature graph-search^
  (search))

;; implementacja przeszukiwania grafu
;; uzależniona od implementacji grafu i struktury danych
(define-unit/contract graph-search@
  (import bag^ graph^)
  (export (graph-search^
           [search (-> graph? any/c (listof any/c))]))
  (define (search g n)
    (define (it g b l)
      (cond
        [(bag-empty? b) (reverse l)]
        [(has-node? g (bag-peek b))
         (it (remove-node g (bag-peek b))
             (foldl
              (lambda (n1 b1) (bag-insert b1 n1))
              (bag-remove b)
              (outnodes g (bag-peek b)))
             (cons (bag-peek b) l))]
        [else (it g (bag-remove b) l)]))
    (it g (bag-insert empty-bag n) '()))
  )

;; otwarcie komponentu grafu
(define-values/invoke-unit/infer simple-graph@)

;; graf testowy
(define test-graph
  (graph
   (list 1 2 3 4)
   (list (edge 1 3)
         (edge 1 2)
         (edge 2 4))))

(define test-graph2
  (graph
   (list 1 2 3 4)
   (list (edge 1 2)
         (edge 2 3)
         (edge 3 4)
         (edge 4 1))))

(define test-graph3
  (graph
   (list 1 2 3)
   (list (edge 1 2)
         (edge 2 3)
         (edge 2 1))))

(define test-graph4
  (graph
   (list 1 2 3 4)
   (list (edge 1 2)
         (edge 1 3)
         (edge 3 2)
         (edge 3 4)
         (edge 4 3))))

(define test-graph5
  (graph
   (list 1 2 3 4 5)
   (list (edge 1 3)
         (edge 2 5)
         (edge 3 2)
         (edge 3 4)
         (edge 5 2)
         (edge 5 5)
         )))

(define test-graph6
  (graph
   (list 1 2 3)
   '()))


;; otwarcie komponentu stosu
;(define-values/invoke-unit/infer bag-stack@)
;; opcja 2: otwarcie komponentu kolejki
(define-values/invoke-unit/infer bag-fifo@)

;; testy w Quickchecku
(require quickcheck)

;; test przykładowy: jeśli do pustej struktury dodamy element
;; i od razu go usuniemy, wynikowa struktura jest pusta
(quickcheck
 (property ([s arbitrary-symbol])
           (bag-empty? (bag-remove (bag-insert empty-bag s)))))

; jeśli do pustej struktury dodamy jeden element x a poźniej zobaczymy co to za element, to będzie to nasz x
(quickcheck
 (property ([s arbitrary-symbol])
           (equal? s (bag-peek (bag-insert empty-bag s)))))

;funkcje pomocnicze
(define (add-all xs b)
  (if (null? xs)
      b
      (add-all (cdr xs) (bag-insert b (car xs)))))
(define (empty-all b)
    (if (bag-empty? b)
        null
        (cons (bag-peek b) (empty-all (bag-remove b)))))

;;TESTY DLA STOSU
;;jeżeli dodamy elementy do stosu i wykonamy bag-peek to zostanie zwrócony ostatnio dodany element
;(quickcheck
; (property ([s1 arbitrary-symbol]
;            [s2 arbitrary-symbol]
;            [s3 arbitrary-symbol])
;           (and (equal? (bag-peek (bag-insert (bag-insert (bag-insert empty-bag s1) s2) s3)) s3)
;                (equal? (bag-peek (bag-insert (bag-insert (bag-insert empty-bag s1) s3) s2)) s2)
;                (equal? (bag-peek (bag-insert (bag-insert (bag-insert empty-bag s3) s2) s1)) s1)
;                )))
;;jak do stosu b dodamy element i go usuniemy to dostaniemy ponownie stos b
;(quickcheck
; (property ([s1 arbitrary-symbol]
;           [s2 arbitrary-symbol]
;           [s3 arbitrary-symbol])
;          (let ([b1 (bag-insert (bag-insert empty-bag s1) s2)])
;            (equal? b1 (bag-remove (bag-insert b1 s3))))))
;
;;jak dodamy do stosu calą listę, a później całą "zdejmiemy" to dostaniemy tą samą listę ale odwróconą
;(quickcheck
; (property ([array (arbitrary-list arbitrary-symbol)])
;          (let ((b1 (add-all array empty-bag)))
;            (equal? (reverse array) (empty-all b1)))))

;TESTY DLA KOLEJKI
;jeżeli dodamy elementy do kolejki i wykonamy bag-peek to zostanie zwrócony pierwszy dodany element
(quickcheck
 (property ([s1 arbitrary-symbol]
            [s2 arbitrary-symbol]
            [s3 arbitrary-symbol])
           (and (equal? (bag-peek (bag-insert (bag-insert (bag-insert empty-bag s1) s2) s3)) s1)
                (equal? (bag-peek (bag-insert (bag-insert (bag-insert empty-bag s1) s3) s2)) s1)
                (equal? (bag-peek (bag-insert (bag-insert (bag-insert empty-bag s3) s2) s1)) s3)
                )))

;jak dodamy do kolejki calą listę, a później całą "zdejmiemy" to dostaniemy tą samą listę
(quickcheck
 (property ([array (arbitrary-list arbitrary-symbol)])
          (let ((b1 (add-all array empty-bag)))
            (equal? array (empty-all b1)))))


;; jeśli jakaś własność dotyczy tylko stosu lub tylko kolejki,
;; wykomentuj ją i opisz to w komentarzu powyżej własności



;; otwarcie komponentu przeszukiwania
(define-values/invoke-unit/infer graph-search@)

;; uruchomienie przeszukiwania na przykładowym grafie
(search test-graph 1)
(search test-graph 2)
(search test-graph 3)
(search test-graph 4)
(display "\n")

(search test-graph2 1)
(search test-graph2 2)
(search test-graph2 3)
(search test-graph2 4)
(display "\n")

(search test-graph3 1)
(search test-graph3 2)
(search test-graph3 3)
(display "\n")

(search test-graph4 1)
(search test-graph4 2)
(search test-graph4 3)
(search test-graph4 4)
(display "\n")

(search test-graph5 1)
(search test-graph5 2)
(search test-graph5 3)
(search test-graph5 4)
(search test-graph5 5)
(display "\n")

(search test-graph6 1)
(search test-graph6 2)
(search test-graph6 3)
(display "\n")