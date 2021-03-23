#lang racket

(require rackunit)
(require rackunit/text-ui)
(define (inc n)
  (+ n 1))

;;; tagged lists
(define (tagged-list? len-xs tag xs)
  (and (list? xs)
       (= len-xs (length xs))
       (eq? (first xs) tag)))

;;; ordered elements
(define (make-elem pri val)
  (cons pri val))

(define (elem-priority x)
  (car x))

(define (elem-val x)
  (cdr x))

;;; leftist heaps (after Okasaki)

;; data representation
(define leaf 'leaf)

(define (leaf? h) (eq? 'leaf h))

(define (hnode? h)
  (and (tagged-list? 5 'hnode h)
       (natural? (caddr h))))

(define (make-hnode elem heap-a heap-b)
  (let ((rank-a (rank heap-a))
        (rank-b (rank heap-b)))
    (if (< rank-a rank-b)
        (list 'hnode elem (inc rank-a) heap-b heap-a)
        (list 'hnode elem (inc rank-b) heap-a heap-b))))

(define (hnode-elem h)
  (second h))

(define (hnode-left h)
  (fourth h))

(define (hnode-right h)
  (fifth h))

(define (hnode-rank h)
  (third h))

(define (hord? p h)
  (or (leaf? h)
      (<= p (elem-priority (hnode-elem h)))))

(define (heap? h)
  (or (leaf? h)
      (and (hnode? h)
           (heap? (hnode-left h))
           (heap? (hnode-right h))
           (<= (rank (hnode-right h))
               (rank (hnode-left h)))
           (= (rank h) (inc (rank (hnode-right h))))
           (hord? (elem-priority (hnode-elem h))
                  (hnode-left h))
           (hord? (elem-priority (hnode-elem h))
                  (hnode-right h)))))

(define (rank h)
  (if (leaf? h)
      0
      (hnode-rank h)))

;; operations

(define empty-heap leaf)

(define (heap-empty? h)
  (leaf? h))

(define (heap-insert elt heap)
  (heap-merge heap (make-hnode elt leaf leaf)))

(define (heap-min heap)
  (hnode-elem heap))

(define (heap-pop heap)
  (heap-merge (hnode-left heap) (hnode-right heap)))

(define (heap-merge h1 h2)
  (cond
   [(leaf? h1) h2]
   [(leaf? h2) h1]
   [else (let ((h1-min (heap-min h1))
               (h2-min (heap-min h2)))
           (if (< (elem-priority h1-min) (elem-priority h2-min))
               (make-hnode h1-min (hnode-left h1) (heap-merge (hnode-right h1) h2))
               (make-hnode h2-min (hnode-left h2) (heap-merge (hnode-right h2) h1))))]))


;;; heapsort. sorts a list of numbers.
(define (heapsort xs)
  (define (popAll h)
    (if (heap-empty? h)
        null
        (cons (elem-val (heap-min h)) (popAll (heap-pop h)))))
  (let ((h (foldl (lambda (x h)
                    (heap-insert (make-elem x x) h))
            empty-heap xs)))
    (popAll h)))

;;; check that a list is sorted (useful for longish lists)
(define (sorted? xs)
  (cond [(null? xs)              true]
        [(null? (cdr xs))        true]
        [(<= (car xs) (cadr xs)) (sorted? (cdr xs))]
        [else                    false]))

;;; generate a list of random numbers of a given length
(define (randlist len max)
  (define (aux len lst)
    (if (= len 0)
        lst
        (aux (- len 1) (cons (random max) lst))))
  (aux len null))

;;testy

(define tests
  (test-suite
   "Tests of heapsort"

   (test-case
    "Przypadki brzegowe"
    (check-equal? (heapsort '()) '())
    (check-equal? (heapsort '(1)) '(1))
    (check-equal? (heapsort '(1 1 1)) '(1 1 1)))

   (test-case
    "Normalne funkcjonowanie"
   (check-true (sorted? (heapsort (randlist 100 1000))))
   (check-true (sorted? (heapsort (randlist 1 1000))))
   (check-true (sorted? (heapsort (randlist 2 1000))))
   (check-true (sorted? (heapsort (randlist 1000 10000)))))  
   ))

(run-tests tests)
