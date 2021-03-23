#lang racket

;;PREDYKATY
(define (var? t)
  (symbol? t))

(define (neg? t)
  (and (list? t)
       (= 2 (length t))
       (eq? 'neg (car t))))

(define (conj? t)
  (and (list? t)
       (= 3 (length t))
       (eq? 'conj (car t))))

(define (disj? t)
  (and (list? t)
       (= 3 (length t))
       (eq? 'disj (car t))))

(define (prop? f)
  (or (var? f)
      (and (neg? f)
           (prop? (neg-subf f)))
      (and (disj? f)
           (prop? (disj-left f))
           (prop? (disj-rght f)))
      (and (conj? f)
           (prop? (conj-left f))
           (prop? (conj-rght f)))))

;;KONSTRUKTORY
(define (neg v)
  (list 'neg v))

(define (conj v1 v2)
  (list 'conj v1 v2))

(define (disj v1 v2)
  (list 'disj v1 v2))

;;SELEKTORY
(define (neg-subf f)
  (second f))

(define (disj-left f)
  (second f))
(define (disj-rght f)
  (third f))

(define (conj-left f)
  (second f))
(define (conj-rght f)
  (third f))

;;PROCEDURA FREE VARS

(define (in-list xs a)
  (if (null? xs)
      false
      (if (eq? (car xs) a)
          true
          (in-list (cdr xs) a))))
(define (merge ys xs)
  (cond [(null? xs) ys]
        [(null? ys) xs]
        [else (let ((a (car xs)))
                (if (in-list ys a)
                    (merge ys (cdr xs))
                    (cons a (merge ys (cdr xs)))))]))
(define (free-vars f)
  (cond [(var? f) (list f)]
        [(neg? f) (free-vars (neg-subf f))]
        [(conj? f) (merge (free-vars (conj-left f)) (free-vars (conj-rght f)))]
        [(disj? f) (merge (free-vars (disj-left f)) (free-vars (disj-rght f)))]))

(define (free-vars2 f)
  (define (aux f xs)
    (cond [(var? f) (if (in-list xs f)
                        xs
                        (cons f xs))]
          [(neg? f) (aux (neg-subf f) xs)]
          [(conj? f) (aux (conj-left f) (aux (conj-rght f) xs))]
          [(disj? f) (aux (disj-left f) (aux (disj-rght f) xs))]))
  (aux f null))
                        


;;Cwiczenie 3

(define (gen-vals xs)
  (if (null? xs)
      (list null)
      (let*
          ((vss (gen-vals (cdr xs)))
           (x (car xs) )
           (vst (map (lambda (vs) (cons (list x true) vs)) vss))
           (vsf (map (lambda (vs) (cons (list x false) vs)) vss)))
        (append vst vsf))))

(define (find-vals f vals)
  (if (eq? f (car (car vals)))
      (car (cdr (car vals)))
      (find-vals f (cdr vals))))

(define (eval-formula f vals)
  (cond [(var? f) (find-vals f vals)]
        [(neg? f) (not (eval-formula (neg-subf f) vals))]
        [(conj? f) (and (eval-formula (conj-left f) vals)
                        (eval-formula (conj-rght f) vals))]
        [(disj? f) (or (eval-formula (disj-left f) vals)
                       (eval-formula (disj-rght f) vals))]))
(define (find-vals2 f vals)
  (if (null? vals)
      -1
      (if (eq? (car (car vals)))
          (car (cdr (car vals)))
          (find-vals2 f (cdr vals)))))

(define (eval-formula2 f vals)
  (cond [(var? f) (find-vals2 f vals)]
        [(neg? f) (let ((v (eval-formula2 (neg-subf f))))
                    (if (= v -1)
                        -1
                        (not v)))]
        [(conj? f) (let ((l (eval-formula2 (conj-left f) vals))
                         (r (eval-formula2 (conj-rght f) vals)))
                     (if (or (= l -1) (= r -1))
                         -1
                         (and l r)))]
        [(disj? f) (let ((l (eval-formula2 (disj-left f) vals))
                         (r (eval-formula2 (disj-rght f) vals)))
                     (if (or (= l -1) (= r -1))
                         -1
                         (or l r)))]))

(define (falsifiable-eval? f)
  (define (aux vals)
    (if (null? vals)
        false
        (let ((eval (eval-formula f (car vals))))
          (if (not eval)
              (car vals)
              (aux (cdr vals))))))
  (aux (gen-vals (free-vars f))))
                   
;;cwiczenie 4

(define (lit? f)
  (or (var? f)
      (and (neg? f)
           (var? (neg-subf f)))))

(define (nnf? f)
  (or (lit? f)
      (and (conj? f)
           (nnf? (conj-left f))
           (nnf? (conj-rght f)))
      (and (disj? f)
           (nnf? (disj-left f))
           (nnf? (disj-rght f)))))


;cwiczenie 5
(define (convert-to-nnf f)
  (cond [(nnf? f) f]
        [(lit? f) f]
        [(neg? f)
         (let ((elem (neg-subf f)))     
           (cond [(neg? elem) (convert-to-nnf (neg-subf elem))]
                 [(conj? elem) (disj (convert-to-nnf (neg (conj-left elem))) (convert-to-nnf (neg (conj-rght elem))))]
                 [(disj? elem) (conj (convert-to-nnf (neg (disj-left elem))) (convert-to-nnf (neg (disj-rght elem))))]))]
        [(conj? f) (conj (convert-to-nnf (conj-left f)) (convert-to-nnf (conj-rght f)))]
        [(disj? f) (disj (convert-to-nnf (disj-left f)) (convert-to-nnf (disj-rght f)))]))

(define (convert-to-nnf2 f)
  (cond [(var? f) f]
        [(conj? f) (conj (convert-to-nnf (conj-left f)) (convert-to-nnf (conj-rght f)))]
        [(disj? f) (disj (convert-to-nnf (disj-left f)) (convert-to-nnf (disj-rght f)))]
        [(neg? f) (nconvert-to-nnf (neg-subf f))]))

(define (nconvert-to-nnf f)
  (cond [(var? f) (neg f)]
        [(conj? f) (disj (nconvert-to-nnf (conj-left f)) (nconvert-to-nnf (conj-rght f)))]
        [(disj? f) (conj (nconvert-to-nnf (disj-left f)) (nconvert-to-nnf (disj-rght f)))]
        [(neg? f) (convert-to-nnf (neg-subf f))]))
;ćwiczenie 6
(define (cnf? f)
  (or (klauzula? f)
      (and (conj? f)
           (cnf? (conj-left f)
                 (conj-rght f)))))

(define (klauzula? f)
  (or (lit? f)
      (and (disj? f)
           (klauzula? (disj-left f))
           (klauzula? (disj-rght f)))))

(define (cnf k1 k2)
  (conj k1 k2))

(define (klauzula l1 l2)
  (disj l1 l2))

(define (convert-to-cnf f)
  (cond [(conj? f) (conj (convert-to-cnf (conj-left f)) (convert-to-cnf (conj-rght f)))]
        [(disj? f) (let ((l (convert-to-cnf (disj-left f)))
                         (r (convert-to-cnf (disj-rght f))))
                     (merge-cnf l r))]
        [(lit? f) f]))

(define (merge-cnf p q)
  (cond [(and (klauzula? p) (klauzula? q)) (disj p q)]
        [(conj? q) (conj (merge-cnf p (conj-left q)) (merge-cnf p (conj-rght q)))]
        [else (conj (merge-cnf (... 
        
  
      


  