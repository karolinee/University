#lang racket

(require racklog)

(define %rodzic ; (%rodzic x y) oznacza, że iks jest rodzicem igreka
  (%rel ()
        [('elżbieta2 'karol)]
        [('elżbieta2 'anna)]
        [('elżbieta2 'andrzej)]
        [('elżbieta2 'edward)]
        [('karol     'william)]
        [('karol     'harry)]
        [('anna      'piotr)]
        [('anna      'zara)]
        [('andrzej   'beatrycze)]
        [('andrzej   'eugenia)]
        [('edward    'james)]
        [('edward    'louise)]
        [('william   'george)]
        [('william   'charlotte)]
        [('william   'louis)]
        [('harry     'archie)]
        [('piotr     'savannah)]
        [('piotr     'isla)]
        [('zara      'mia)]
        [('zara      'lena)]))

(define %rok-urodzenia
  (%rel ()
        [('elżbieta2 1926)]
        [('karol     1948)]
        [('anna      1950)]
        [('andrzej   1960)]
        [('edward    1964)]
        [('william   1982)]
        [('harry     1984)]
        [('piotr     1977)]
        [('zara      1981)]
        [('beatrycze 1988)]
        [('euagenia  1990)]
        [('james     2007)]
        [('louise    2003)]
        [('george    2013)]
        [('charlotte 2015)]
        [('louis     2018)]
        [('archie    2019)]
        [('savannah  2010)]
        [('isla      2012)]
        [('mia       2014)]
        [('lena      2018)]))

(define %plec
  (%rel ()
        [('elżbieta2 'k)]
        [('karol     'm)]
        [('anna      'k)]
        [('andrzej   'm)]
        [('edward    'm)]
        [('william   'm)]
        [('harry     'm)]
        [('piotr     'm)]
        [('zara      'k)]
        [('beatrycze 'k)]
        [('euagenia  'k)]
        [('james     'm)]
        [('louise    'k)]
        [('george    'm)]
        [('charlotte 'k)]
        [('louis     'm)]
        [('archie    'm)]
        [('savannah  'k)]
        [('isla      'k)]
        [('mia       'k)]
        [('lena      'k)]))

(define %spadl-z-konia
  (%rel ()
        [('anna)]))

;;ćwiczenie1
(define %babcia
  (%rel (x y z)
        [(x z)
         (%plec x 'k)
         (%rodzic x y)
         (%rodzic y z)]))

(define %prababcia
  (%rel (x y z)
        [(x z)
         (%babcia x y)
         (%rodzic y z)]))

(define %urodziny-wnuka
  (%rel (x y z)
        [(x y z)
         (%prababcia x y)
         (%rok-urodzenia y z)]))

(define %ile-lat
  (%rel (x y t)
        [(x y)
         (%rok-urodzenia x t)
         (%is y (- 2019 t))
         ]))

(define %wiek-prawnukow
  (%rel (x y t)
        [(x y t)
         (%prababcia x y)
         (%ile-lat y t)]))

(define %kuzyni
  (%rel (x y z)
        [(x y)
         (%prababcia z x)
         (%prababcia z y)]
        [(x y)
         (%babcia z x)
         (%babcia z y)]))



;;ćwiczenie2
(define %starszy
  (%rel (x y xw yw)
        [(x y)
         (%ile-lat x xw)
         (%ile-lat y yw)
         (%< xw yw)]))

(define %starszyZLE
  (%rel (x y xw yw)
        [(x y)
         (%ile-lat x xw)
         (%ile-lat y yw)
         (%< xw yw)]))
(define %starsze-rodzenstwo
  (%rel (x y r)
        [(x y)
         (%rodzic r x)
         (%rodzic r y)
         (%starszy x y)]))

(define %rodzenstwo
  (%rel (x y z)
        [(x y)
         (%rodzic z x)
         (%rodzic z y)]))
(define %wyprzedza
  (%rel (x y z)
        [(x y)
         (%starsze-rodzenstwo x y)]
        [(x y)
         (%rodzic y x)]
        [(x y)
         (%rodzic y z)
         (%wyprzedza z y)]
        [(x y)
         (%starsze-rodzenstwo z y)
         (%rodzenstwo x z)]
        ))

;;ćwiczenie3

;(define %reverse
;  (%rel (x xs ys acc)
;        [(xs ys)
;         (%reverse xs ys '())]
;        [('() acc acc)]
;        [((cons x xs) ys acc)
;         (%reverse xs ys (cons x acc))]
;        ))

(define %reverse
  (%rel (x xs ys ś dl acc)
        [(xs ys)
         (%reverse xs ys ys '())]
        [('() acc '() acc)]
        [((cons x xs) ys (cons ś dl) acc)
         (%reverse xs ys dl (cons x acc))]
        ))
(define xs '(1 2 3 4 5))

;;ćwiczenie6

(define %merge
  (%rel (x xs y ys zs)
        [('() ys ys)]
        [(xs '() xs)]
        [((cons x xs) (cons y ys) (cons x zs))
         (%< x y)
         (%merge xs (cons y ys) zs)]
        [((cons x xs) (cons y ys) (cons y zs))
         (%merge (cons x xs) ys zs)]))

(define %podzial
  (%rel (x y xs xs1 xs2)
        [('() '() '())]
        [((cons x null) (cons x null) '())]
        [((cons x (cons y xs)) (cons x xs1) (cons y xs2))
         (%podzial xs xs1 xs2)]))

(define %mergesort
  (%rel (x xs xs1 xs2 ys ys1 ys2)
        [('() '())]
        [((cons x null) (cons x null))]
        [(xs ys)
         (%podzial xs xs1 xs2)
         (%mergesort xs1 ys1)
         (%mergesort xs2 ys2)
         (%merge ys1 ys2 ys)]))

;;ćwiczenie7
(define %sorted
  (%rel (x y xs b1 b2 b)
        [('() true)]
        [((cons x null) true)]
        [((cons x (cons y xs)) false)
         (%sorted xs false)]
        [((cons x (cons y xs)) true)
         (%<= x y)
         (%sorted xs true)]
        [((cons x (cons y xs)) false)
         (%> x y)
         (%sorted xs (_))]))


         
         
        

;;cwiczenie8
(define %plecak
  (%rel (n h w t nn xs)
        [(0 (_) null)]
        [(n (cons h w) (cons h t))
         (%is nn (- n h))
         (%>= nn 0)
         (%plecak nn w t)]
        [(n (cons (_) w) t)
         (%plecak n w t)]))
         


