#lang racket


;;Rozwiazanie poprzednich dwóch zadań jest skopiowane od Jacka Bizub (co zostało dozwolone przez profesora Sieczkowskiego)

(require rackunit)
(require rackunit/text-ui)

;; procedury pomocnicze
(define (tagged-tuple? tag len x)
  (and (list? x)
       (=   len (length x))
       (eq? tag (car x))))

(define (tagged-list? tag x)
  (and (pair? x)
       (eq? tag (car x))
       (list? (cdr x))))

;; reprezentacja formuł w CNFie
;; zmienne
(define (var? x)
  (symbol? x))

(define (var x)
  x)

(define (var-name x)
  x)

(define (var<? x y)
  (symbol<? x y))

;; literały
(define (lit pol var)
  (list 'lit pol var))

(define (pos x)
  (lit true (var x)))

(define (neg x)
  (lit false (var x)))

(define (lit? x)
  (and (tagged-tuple? 'lit 3 x)
       (boolean? (second x))
       (var? (third x))))

(define (lit-pol l)
  (second l))

(define (lit-var l)
  (third l))

;; klauzule
(define (clause? c)
  (and (tagged-list? 'clause c)
       (andmap lit? (cdr c))))

(define (clause . lits)
  (cons 'clause lits))

(define (clause-lits c)
  (cdr c))

(define (cnf? f)
  (and (tagged-list? 'cnf f)
       (andmap clause? (cdr f))))

(define (cnf . clauses)
  (cons 'cnf clauses))

(define (cnf-clauses f)
  (cdr f))

;; definicja rezolucyjnych drzew wyprowadzenia
(define (axiom? p)
  (tagged-tuple? 'axiom 2 p))

(define (axiom c)
  (list 'axiom c))

(define (axiom-clause a)
  (second a))

(define (res? p)
  (tagged-tuple? 'res 4 p))

(define (res x pf-pos pf-neg)
  (list 'res x pf-pos pf-neg))

(define (res-var p)
  (second p))
(define (res-proof-pos p)
  (third p))
(define (res-proof-neg p)
  (fourth p))

(define (proof? p)
  (if
   (or (and (axiom? p)
            (clause? (axiom-clause p)))
       (and (res? p)
            (var? (res-var p))
            (proof? (res-proof-pos p))
            (proof? (res-proof-neg p))))
   true
   false))

;; sprawdza czy element znajduje sie na liscie
(define (in? x xs)
  (if (null? xs)
      false
      (if (equal? x (car xs))
          true
          (in? x (cdr xs)))))

;; usuwa literal z klauzuli
(define (remove-lit l cs)
  (if (null? cs)
      null
      (if (equal? l (car cs))
          (remove-lit l (cdr cs))
          (cons (car cs)
                (remove-lit l (cdr cs))))))

(define (merge-clauses c1 c2)
  (if (or (equal? c1 false)
          (equal? c2 false))
      false
      (append c1 (clause-lits c2))))

(define (proof-result pf prop-cnf)
  ;; "zwraca" pare skladajaca sie z rezolwenty czesciowej i nowej listy klauzul
  (define (resolvent r variable clauses-list)
    ;; sprawdza czy do rezolucji nie zostaly wrzucone losowe klauzule
    (define (proper-clause? c)
      (in? c clauses-list))
    
    (cond [(axiom? r)
           (if (and (proper-clause? (axiom-clause r))
                    (in? variable (axiom-clause r)))
               (let ([resolv (axiom (remove-lit variable (axiom-clause r)))])
                 (if (not (equal? resolv false))
                     (cons resolv
                           ;dodaj nowa klauzule do listy
                           (cons (axiom-clause resolv) clauses-list))
                     false))
               false)]
          [(res? r)
           (let* ([resolv1 (resolvent (res-proof-pos r) (pos (res-var r)) clauses-list)]
                  [resolv2 (resolvent (res-proof-neg r) (neg (res-var r)) clauses-list)]
                  [resolv (and (not (equal? resolv1 false))
                               (not (equal? resolv2 false))
                               (axiom (remove-duplicates (merge-clauses (axiom-clause (car resolv1)) (axiom-clause (car resolv2))))))])
             (if (and (not (equal? resolv false))
                      (or (in? variable (axiom-clause resolv))
                          (equal? variable null))) ;; wywolanie procedury
                 (let ([resolv (axiom (remove-lit variable (axiom-clause resolv)))])
                   (cons resolv
                         (cons (axiom-clause resolv) clauses-list)))
                 false))]))
    
  (if (proof? pf)
      (let ([f (resolvent pf null prop-cnf)])
        (and (not (equal? f false))
             (axiom-clause (car f))))
      false))

(define (check-proof? pf prop)
  (let ((c (proof-result pf prop)))
    (and (clause? c)
         (null? (clause-lits c)))))

;; XXX: Zestaw testów do zadania pierwszego

(define proof-checking-tests
  (test-suite
   "Proof checking tests"

   (test-case
    "A resolution proof of contradictions test"
    (check-equal? (check-proof? '(res q (res p (axiom (clause (lit #t p) (lit #t q))) (axiom (clause (lit #f p) (lit #t q))))
                                      (res r (axiom (clause (lit #f q) (lit #t r))) (axiom (clause (lit #f q) (lit #f r)))))
                                '(cnf (clause (lit #f p) (lit #t q))
                                      (clause (lit #t p) (lit #t q))
                                      (clause (lit #f q) (lit #t r))
                                      (clause (lit #f q) (lit #f r))))
                  true))

   (test-case
    "Resolvent finding test"
    (check-equal? (proof-result (res (var 'q) (axiom (clause (lit #t 'p) (lit #t 'q)))
                                     (axiom (clause (lit #t 'r) (lit #f 'q)))) ;; p v q & r v ~q
                                (cnf (clause (lit #t 'p) (lit #t 'q))
                                     (clause (lit #t 'r) (lit #f 'q))))
                  '(clause (lit #t p) (lit #t r)) ;; p v r
                  ))

   (test-case
    "An invalid proof input test"
    (check-equal? (proof-result (res (var 'q) (axiom (clause (lit #t 'p) (lit #t 'q)))
                                     (axiom (clause (lit #t 'x) (lit #f 'q)))) ;; p v q & x v ~q
                                (cnf (clause (lit #t 'p) (lit #t 'q))
                                     (clause (lit #t 'r) (lit #f 'q))))        ;; brak x na liscie
                  false)

    (check-equal? (proof-result (res (var 'q) (axiom (clause (lit #t 'p) (lit #t 'q)))
                                     (axiom (clause (lit #t 'x) (lit #t 'p)))) ;; p v q & x v p ;; brak negacji q
                                (cnf (clause (lit #t 'p) (lit #t 'q))
                                     (clause (lit #t 'x) (lit #t 'p))))
                  false))))

(run-tests proof-checking-tests)


;; Wewnętrzna reprezentacja klauzul

(define (sorted? ord? xs)
  (or (null? xs)
      (null? (cdr xs))
      (and (ord? (car xs)
                 (cadr xs))
           (sorted? ord? (cdr xs)))))

(define (sorted-varlist? xs)
  (and (andmap var? xs)
       (sorted? var<? xs)))

(define (res-clause pos neg pf)
  (list 'res-clause pos neg pf))

(define (res-clause-pos rc)
  (second rc))
(define (res-clause-neg rc)
  (third rc))
(define (res-clause-proof rc)
  (fourth rc))

(define (res-clause? p)
  (and (tagged-tuple? 'res-clause 4 p)
       (sorted-varlist? (second p))
       (sorted-varlist? (third  p))
       (proof? (fourth p))))

;; implementacja zbiorów / kolejek klauzul do przetworzenia

(define clause-set-empty
  '(stop () ()))

(define (clause-set-add rc rc-set)
  (define (eq-cl? sc)
    (and (equal? (res-clause-pos rc)
                 (res-clause-pos sc))
         (equal? (res-clause-neg rc)
                 (res-clause-neg sc))))
  (define (add-to-stopped sset)
    (let ((procd  (cadr  sset))
          (toproc (caddr sset)))
      (cond
        [(null? procd) (list 'stop (list rc) '())]
        [(or (memf eq-cl? procd)
             (memf eq-cl? toproc))
         sset]
        [else (list 'stop procd (cons rc toproc))])))
  (define (add-to-running rset)
    (let ((pd  (second rset))
          (tp  (third  rset))
          (cc  (fourth rset))
          (rst (fifth  rset)))
      (if (or (memf eq-cl? pd)
              (memf eq-cl? tp)
              (eq-cl? cc)
              (memf eq-cl? rst))
          rset
          (list 'run pd tp cc (cons rc rst)))))
  (if (eq? 'stop (car rc-set))
      (add-to-stopped rc-set)
      (add-to-running rc-set)))

(define (clause-set-done? rc-set)
  (and (eq? 'stop (car rc-set))
       (null? (caddr rc-set))))

(define (clause-set-next-pair rc-set)
  (define (aux rset)
    (let* ((pd  (second rset))
           (tp  (third  rset))
           (nc  (car tp))
           (rtp (cdr tp))
           (cc  (fourth rset))
           (rst (fifth  rset))
           (ns  (if (null? rtp)
                    (list 'stop (cons cc (cons nc pd)) rst)
                    (list 'run  (cons nc pd) rtp cc rst))))
      (cons cc (cons nc ns))))
  (if (eq? 'stop (car rc-set))
      (let ((pd (second rc-set))
            (tp (third  rc-set)))
        (aux (list 'run '() pd (car tp) (cdr tp))))
      (aux rc-set)))

(define (clause-set-done->clause-list rc-set)
  (and (clause-set-done? rc-set)
       (cadr rc-set)))

;; konwersja z reprezentacji wejściowej na wewnętrzną

(define (clause->res-clause cl)
  (let ((pos (filter-map (lambda (l) (and (lit-pol l) (lit-var l)))
                         (clause-lits cl)))
        (neg (filter-map (lambda (l) (and (not (lit-pol l)) (lit-var l)))
                         (clause-lits cl)))
        (pf  (axiom cl)))
    (res-clause (sort pos var<?) (sort neg var<?) pf)))

;; tu zdefiniuj procedury pomocnicze, jeśli potrzebujesz

(define (any-duplicate? rc1 rc2)
  (cond [(null? rc1) false]
        [(in? (car rc1) rc2) (car rc1)]
        [else (any-duplicate? (cdr rc1) rc2)]))

(define (merge-res-clause-branches b1 b2)
  (define (append-with-sorting lit b)
    (cond [(null? lit) b]
          [(null? b) (list lit)]
          [(var<? lit (car b))
           (cons lit b)]
          [else (cons (car b) (append-with-sorting lit (cdr b)))]))

  (define (merge-step b result)
    (if (null? b)
        result
        (merge-step (cdr b) (append-with-sorting (car b) result))))

  (merge-step b1 b2))

(define (rc-trivial? rc)
  (let ([answer (any-duplicate? (res-clause-pos rc) (res-clause-neg rc))])
    
    (if (equal? answer false)
        false
        true)))

(define (rc-resolve rc1 rc2)
  (let* ([duplicated-variable (or (any-duplicate? (res-clause-pos rc1)
                                                  (res-clause-neg rc2))
                                  (any-duplicate? (res-clause-neg rc1)
                                                  (res-clause-pos rc2)))]
         [pos-variable-holder (if (in? duplicated-variable (res-clause-pos rc1))
                                  rc1
                                  rc2)]
         [neg-variable-holder (if (equal? pos-variable-holder rc1)
                                  rc2
                                  rc1)])
    (if (not (equal? false duplicated-variable))
        (let ([pos-literals (merge-res-clause-branches (remove-lit duplicated-variable (res-clause-pos pos-variable-holder))
                                                       (res-clause-pos neg-variable-holder))]
              [neg-literals (merge-res-clause-branches (remove-lit duplicated-variable (res-clause-neg neg-variable-holder))
                                                       (res-clause-neg pos-variable-holder))]
              [resolv-proof (res duplicated-variable
                                 (res-clause-proof pos-variable-holder)
                                 (res-clause-proof neg-variable-holder))])
          (res-clause pos-literals neg-literals resolv-proof))
        false)))

(define (fixed-point op start)
  (let ((new (op start)))
    (if (eq? new false)
        start
        (fixed-point op new))))

(define (cnf->clause-set f)
  (define (aux cl rc-set)
    (clause-set-add (clause->res-clause cl) rc-set))
  (foldl aux clause-set-empty (cnf-clauses f)))

(define (get-empty-proof rc-set)
  (define (rc-empty? c)
    (and (null? (res-clause-pos c))
         (null? (res-clause-neg c))))
  (let* ((rcs (clause-set-done->clause-list rc-set))
         (empty-or-false (findf rc-empty? rcs)))
    (and empty-or-false
         (res-clause-proof empty-or-false))))

(define (improve rc-set)
  (if (clause-set-done? rc-set)
      false
      (let* ((triple (clause-set-next-pair rc-set))
             (c1     (car  triple))
             (c2     (cadr triple))
             (rc-set (cddr triple))
             (c-or-f (rc-resolve c1 c2)))
        (if (and c-or-f (not (rc-trivial? c-or-f)))
            (clause-set-add c-or-f rc-set)
            rc-set))))

(define (prove cnf-form)
  (let* ((clauses (cnf->clause-set cnf-form))
         (sat-clauses (fixed-point improve clauses))
         (pf-or-false (get-empty-proof sat-clauses)))
    (if (eq? pf-or-false false)
        'sat
        (list 'unsat pf-or-false))))

;;;PRACOWNIA LISTA 6
(define (subsumes? p q)
  (and (includes (res-clause-pos p) (res-clause-pos q))
       (includes (res-clause-neg q) (res-clause-neg q))))

(define (includes xs ys)
  (if (null? xs)
      true
      (if (in? (car xs) ys)
          (includes (cdr xs) ys)
          false)))
          
  
;; XXX: Zestaw testów do zadania drugiego

(define resolution-tests
  (test-suite
   ""
 
   (test-suite
    "Helper procedures tests"

    (test-case
     "any-duplicate? tests"

     (check-equal? (any-duplicate? (list 1 2 3)
                                   (list 4 5 6))
                   false)
     
     (check-equal? (any-duplicate? (list 1 2 3 4)
                                   (list 4 5 6))
                   4)
     
     (check-equal? (any-duplicate? '(1 2)
                                   '())
                   false))

    (test-case
     "merge-res-clause-branches tests"

     (check-equal? (merge-res-clause-branches '(p)
                                              '())
                   '(p))
     
     (check-equal? (merge-res-clause-branches '()
                                              '(p q))
                   '(p q))
     
     (check-equal? (merge-res-clause-branches '(a b c z)
                                              '(q p))
                   '(a b c q p z)))

    (test-case
     "rc-trivial? tests"

     (check-equal? (rc-trivial? (res-clause '(p) '(p)
                                            'pf))
                   true)

     (check-equal? (rc-trivial? (res-clause '(a b c d e f g) '(e l m n)
                                            'pf))
                   true)

     (check-equal? (rc-trivial? (res-clause '() '(p)
                                            'pf))
                   false)

     (check-equal? (rc-trivial? (res-clause '(a b) '(c d e)
                                            'pf))
                   false)))

   (test-case
    "Clauses resolving tests"

    (check-equal? (rc-resolve (res-clause '(p q z) '()
                                          'pf1)
                              (res-clause '() '(q)
                                          'pf2))
                  (res-clause '(p z) '()
                              (res 'q 'pf1 'pf2)))

    (check-equal? (rc-resolve (res-clause '(p) '()
                                          'pf1)
                              (res-clause '() '(p)
                                          'pf2))
                  (res-clause '() '() (res 'p 'pf1 'pf2))))

   (test-case
    "Proving tests"
    
    (let ([test-cnf1 '(cnf (clause (lit #f p) (lit #t q))
                           (clause (lit #t p) (lit #t q))
                           (clause (lit #f q) (lit #t r))
                           (clause (lit #f q) (lit #f r)))] ;; ~p v q & p v q & ~q v r & ~q v ~r
          [test-cnf2 (cnf  (clause (pos 'q))
                           (clause (neg 'q))
                           (clause (pos 'q) (neg 'r))
                           (clause (neg 'r)))]              ;; q & ~q & q v ~r & ~r
          [test-cnf3 (cnf (clause (pos 'q) (pos 'r))
                          (clause (neg 'q)))])              ;; q v r & ~q
      
      (check-equal? (prove test-cnf3)
                    'sat)

      (check-equal? (check-proof? (prove test-cnf3) test-cnf3)
                    false)
      
      (check-equal? (prove test-cnf1)
                    '(unsat
                      (res
                       q
                       (res
                        p
                        (axiom (clause (lit #t p) (lit #t q)))
                        (res
                         q
                         (axiom (clause (lit #f p) (lit #t q)))
                         (res
                          r
                          (axiom (clause (lit #f q) (lit #t r)))
                          (axiom (clause (lit #f q) (lit #f r))))))
                       (res
                        r
                        (axiom (clause (lit #f q) (lit #t r)))
                        (axiom (clause (lit #f q) (lit #f r)))))))
      
      (check-equal? (check-proof? (cadr (prove test-cnf1)) test-cnf1)
                    true)

      (check-equal? (prove test-cnf2)
                    '(unsat
                      (res q
                           (axiom (clause (lit #t q)))
                           (axiom (clause (lit #f q))))))

      (check-equal? (check-proof? (cadr (prove test-cnf2)) test-cnf2)
                    true)))))

(run-tests resolution-tests)