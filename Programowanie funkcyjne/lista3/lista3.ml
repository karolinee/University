(*zadanie 1*)
let length_fold xs = 
    List.fold_right (fun _ x -> x + 1) xs 0;;

let rev_fold xs = 
    List.fold_left (fun acc x -> x::acc) [] xs;;

let map_fold f xs =
    List.fold_right (fun x acc -> (f x)::acc) xs [];;

let append_fold xs ys =
    List.fold_right (fun x acc -> x::acc) xs ys;; 

let rev_append_fold xs ys =
    List.fold_left (fun acc x -> x::acc) ys xs;;

let filter_fold f xs =
    List.fold_right (fun x acc -> if (f x) then x::acc else acc) xs [];;

let rev_map_fold f xs =
    List.fold_left (fun acc x -> (f x)::acc) [] xs;;

(*zadanie 2*)
let list_to_int_rec xs = 
    let rec aux xs acc =
        match xs with
        | [] -> acc
        | hd::tl -> aux tl (10*acc + hd)
    in aux xs 0;;

let list_to_int xs = 
    List.fold_left (fun acc x -> 10*acc + x) 0 xs;;

(*zadanie 3*)
(* (polynomial: float list -> float -> float) *)
let polynomial_rec_tail xs x = 
    let rec aux xs acc = 
        match xs with
        | [] -> acc
        | hd::tl -> aux tl (hd +. (x*.acc))
    in aux xs 0.;;

let polynomial xs x = 
    List.fold_left (fun acc y -> y +. (x*.acc)) 0. xs;;

(*zadanie 4*)
let rec polynomial_rec2 xs x =
    match xs with
    | [] -> 0.
    | hd::tl -> hd +. (x *. (polynomial_rec2 tl x));;

let polynomial_fold_right xs x =
    List.fold_right (fun y acc -> y +. (x*.acc)) xs 0.;;

let polynomial_rec_tail2 xs x =
    let rec aux xs acc y =
        match xs with
        | [] -> acc
        | hd::tl -> aux tl (acc +. hd*.y) (y*.x)
    in aux xs 0. 1.;;

let polynomial_fold_left xs x =
    fst (List.fold_left (fun (acc, pov) y -> (acc +. pov *. y, pov *. x)) (0., 1.) xs);;

(* zadanie 5*)
(* for_all: ('a -> bool) -> 'a list -> bool*)
exception End_fold;;
let for_all f xs =
    try List.fold_left (fun acc x -> if f x then acc else raise End_fold) true xs
    with End_fold -> false;;
(* poprawione *)
let for_all f xs =
    try List.fold_left (fun acc x -> f x || raise End_fold) true xs
    with End_fold -> false;;

(* mult_list: int list -> int*)
let mult_list xs = 
    try List.fold_left (fun acc x -> if x <> 0 then x*acc else raise End_fold) 1 xs
    with End_fold -> 0;; 

(* sorted: int list -> bool*)
let sorted xs = 
    match xs with 
    | [] -> true
    | hd::tl -> try fst (List.fold_left (fun (sort, acc)  x -> if acc <= x then (true, x) else raise End_fold) (true, hd) tl)
    with End_fold -> false;; 
(* poprawione *)
let sorted xs = 
    match xs with
    | [] -> true
    | hd::tl -> try let _ = List.fold_left (fun acc x -> if acc <= x then x else raise End_fold) hd tl in true with End_fold -> false;;

(* zadanie 6 *)
(* List.fold_left: ('a -> 'b -> 'a) -> 'a -> 'b list -> 'a *)
(* fold_left_cps : (’a -> ’b -> (’a -> ’c) -> ’c) -> ’a -> ’b list -> (’a -> ’c) -> ’c *)

let rec fold_left_cps f acc xs k =
    match xs with
    | [] -> k acc
    | hd::tl -> f acc hd (fun nacc -> fold_left_cps f nacc tl k);;

let fold_left f acc xs = fold_left_cps (fun acc x k -> k (f acc x)) acc xs (fun x -> x);;


(* zadanie 7*)
let for_all_cps f xs =
    fold_left_cps (fun acc x k -> if f x then k acc else false) true xs (fun x -> x);;
(*poprawione *)
let for_all_cps f xs =
    fold_left_cps (fun () x k -> f x && k ()) () xs (fun _ -> true);;

let mult_list_cps xs = 
    fold_left_cps (fun acc x k -> if x <> 0 then k (x * acc) else 0) 1 xs (fun x -> x);;

let sorted_cps xs = 
    match xs with
    | [] -> true
    | hd::tl -> fold_left_cps (fun acc x k -> if acc <= x then k x else false) hd tl (fun _ -> true);;


(* zadanie 8 *)
(* map : (’i -> ’o) -> (’a, ’z, ’i, ’o) proc *)
let rec map f k =
    recv (fun v ->
    send (f v) (fun () ->
    map f k));;
run (map String.length <|>> map string_of_int);;

(* filter : (’i -> bool) -> (’a, ’z, ’i, ’i) proc — *)
let rec filter f k =
    recv (fun v ->
    if f v then send v (fun () -> filter f k) 
    else filter f k);;

run (filter (fun s -> String.length s >= 5));;

(*nats_from : int -> (’a, ’z, ’i, int) proc*)
let rec nats_from n k =
    send n (fun () -> nats_from (n+1) k);;

run (nats_from 5 <|>> map string_of_int);;  

(* sieve : (’a, ’a, int, int) proc *)
let rec sieve k = 
    recv (fun v ->
    send v (fun () ->
    (filter (fun n -> n mod v <> 0 ) <|>> sieve) k));;

run (nats_from 2 <|>> sieve <|>> map string_of_int);;
