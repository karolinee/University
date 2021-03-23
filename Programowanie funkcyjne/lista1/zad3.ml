let hd s = s 0;;

let tl s x = s (x + 1);;

let add s c x = s x + c;;

let map s f x = f (s x);;

let map2 s1 s2 f x = f (s1 x) (s2 x);;

let replace s n a x =
    if (x mod n == 0) then a else s x;;

let take s n x = s (x * n);;

let rec scan s f a n = 
    if n > 0 then f (scan s f a (n-1)) (s n)
    else f a 0;;

let rec tabulate s ?(i1=0) i2 = 
    if i1 == i2 then (s i1)::[]
    else (s i1)::(tabulate s ~i1:(i1 + 1) i2);;


let s1 x = x;;
hd s1;;

let s2 = tl s1;;
s2 0;;

let s2 = add s1 3;;
s2 0;;
s2 1;;

let s2 = map s1 (fun x-> (-x));;
s2 0;;
s2 1;;
s2 2;;

let s3 = map2 s1 s2 (fun x y -> x+y);;
s3 0;;
s3 1;;
s3 2;;

let s2 = replace s1 2 0;;
s2 0;;
s2 1;;
s2 2;;

let s2 = take s1 2;;
s2 0;;
s2 1;;
s2 2;;

let s2 = scan s1 (fun x y -> x + y) 0;;
s2 0;;
s2 1;;
s2 2;;

let res = tabulate s1 4;;
res;;
