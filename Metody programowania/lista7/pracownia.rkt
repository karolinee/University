#lang racket

(require rackunit)
(require rackunit/text-ui)

;;definicja wyrażeń arytmetycznych z jedną zmienną
(struct const (val) #:transparent) ;stala
(struct variable () #:transparent) ;zmienna
(struct op (symb l r) #:transparent) ;dodawanie i mnozenie
(struct diff (expr) #:transparent) ;pochodna

(define (expr? e)
  (match e
    [(variable)         true]
    [(const n)          (number? n)]
    [(op s l r)         (and (member s '(+ *))
                             (expr? l)
                             (expr? r))]
    [(diff e1)          (expr? e1)]
    [_                  false]))

;;ewaluator wyrażeń arytmetycznych
(define (eval e x)
  (define (∂ f)
    (match f
      [(const n)   (const 0)]
      [(variable)  (const 1)]
      [(op '+ f g) (op '+ (∂ f) (∂ g))]
      [(op '* f g) (op '+ (op '* (∂ f) g)
                       (op '* f (∂ g)))]))
  (match e
    [(const n) n]
    [(variable) x]
    [(op '+ l r) (+ (eval l x) (eval r x))]
    [(op '* l r) (* (eval l x) (eval r x))]
    [(diff e1) (eval (∂ e1) x)]))



;;testy
(define tests
  (test-suite
   "Testy wyrazen arytmetycznych"
   
   (test-case
    "Przypadki brzegowe"
    (check-eq? (eval (const 4) 7) 4 "liczenie warosci stalej")
    (check-eq? (eval (variable) 7) 7 "podstawianie za zmienna")
    (check-eq? (eval (diff (const 5)) 7) 0 "pochodna wartosci stalej")
    (check-eq? (eval (diff (variable)) 7) 1 "pochodna zmiennej")
    (check-eq? (eval (diff (op '* (variable) (variable))) 4) 8 "pochodna kwadratu zmennej (pochodna iloczynu)"))
   
  
   (test-case
    "Przykladowe wyrazenia"
    (check-eq? (eval (op '+ (variable) (const 5)) 2) 7 "2x + 5 dla x = 2")
    (check-eq? (eval (op '+ (op '* (const 2) (variable))
                         (diff (op '+
                                   (op '* (variable) (variable))
                                   (variable)))) 3) 13 "2x + ∂(x^2 + x) dla x = 3"))
      
   ))


(run-tests tests)