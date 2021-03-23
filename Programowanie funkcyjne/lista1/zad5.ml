let zero (f: 'a -> 'a) (x: 'a) = x;;

let succ (cn: ('a -> 'a) -> 'a -> 'a) (f: 'a -> 'a) (x: 'a) = f (cn f x);;

let add (cn1: ('a -> 'a) -> 'a -> 'a) (cn2: ('a -> 'a) -> 'a -> 'a) (f: 'a -> 'a) (x: 'a) = cn1 f (cn2 f x);;

let mul (cn1: ('a -> 'a) -> 'a -> 'a) (cn2: ('a -> 'a) -> 'a -> 'a) (f: 'a -> 'a) (x: 'a) = cn1 (cn2 f) x;;

let is_zero (cn: ('a -> 'a) -> 'a -> 'a) (x: 'a) (y: 'a)= cn (fun _ -> y) x;;

let rec cnum_of_int (n: int) (f: 'a -> 'a) (x: 'a) =
    if n == 0 then x
    else f (cnum_of_int (n-1) f x);;

let int_of_cnum (cn: ((int -> int) -> int -> int)) = cn (fun x -> x+1) 0;;