let ctrue (x: 'a) (y: 'a) = x;;

let cfalse (x: 'a) (y: 'a) = y;;

let cand (c1: 'a -> 'a -> 'a) (c2: 'a -> 'a -> 'a) x y = c1 (c2 x y) y ;;

let cor (c1: 'a -> 'a -> 'a) (c2: 'a -> 'a -> 'a) x y = c1 x (c2 x y);;

let cbool_of_bool b = 
    if b then ctrue 
    else cfalse;;

let bool_of_cbool (c: bool -> bool-> bool) = c true false;;