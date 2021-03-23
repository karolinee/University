(* zadanie 1 poprawione*)
let rec append_append_add xs xs2 x = 
    match xs with
    | [] -> xs2
    | hd::tl -> (x::hd)::(append_append_add tl xs2 x);;

let rec sublists xs =
    match xs with
    | [] -> [[]]
    | hd::tl -> let sb = sublists tl in (append_append_add sb sb hd);;



(* zadanie 2 *)
let cycle xs n =
    let rec aux xs acc n = 
        match xs, n with
        | [], _ -> xs
        | _, 0 -> xs @ (List.rev acc)
        | hd::tl, n -> aux tl (hd::acc) (n-1)
    in aux xs [] (List.length xs - n);;

(* zadanie 3.1 *)
let rec merge cmp xs ys = 
    match xs,ys with
    | [],_ -> ys
    | _,[] -> xs
    | hdx::ltx, hdy::lty ->
    if cmp hdx hdy then hdx::(merge cmp ltx ys) else hdy::(merge cmp xs lty);;

(* zadanie 3.2 *)
let mergeRecTail cmp l1 l2 = 
    let rec aux xs ys acc =
        match xs,ys with
        | [],[] -> acc
        | [], hd::tl | hd::tl, [] -> aux [] tl (hd::acc)
        | hdx::ltx, hdy::lty ->
        if cmp hdx hdy then aux ltx ys (hdx::acc) else aux xs lty (hdy::acc)
    in List.rev (aux l1 l2 []);;

let mergeRecTail2 cmp l1 l2 = 
    let rec aux xs ys acc =
        match xs,ys with
        | [],[] -> acc
        | [], hd::tl | hd::tl, [] -> aux [] tl (hd::acc)
        | hdx::ltx, hdy::lty ->
        if cmp hdx hdy then aux ltx ys (hdx::acc) else aux xs lty (hdy::acc)
    in aux l1 l2 [];;

(* zadanie 3.3 *)
let halve list =
    let rec aux acc list counter = 
        match counter with
        | [] | [_] -> (List.rev acc), list 
        | hd::tail -> aux (List.hd list::acc) (List.tl list) (List.tl tail)   
    in aux [] list list;;

(* zadanie 3.4 *)
let rec mergesort list cmp = 
    match list with
    | [] | [_] -> list
    | _::_ -> let left, right = halve list in merge cmp (mergesort left cmp) (mergesort right cmp);;  

(* zadanie 3.5 poprawione*)
let rec mergesort' cmp list = 
    match list with
    | [] | [_] -> list
    | _::_ -> let xs, ys = halve list in mergeRecTail2 (fun x y -> not(cmp x y)) (mergesort' (fun x y -> not(cmp x y)) xs) (mergesort' (fun x y -> not(cmp x y)) ys);;


(* zadanie 4 *)
let rec permutation list =
    let rec insertAll x xs =
        match xs with
        | [] -> [[x]]
        | hd::tl -> (x::xs)::(List.map (fun xs -> hd::xs) (insertAll x tl))
    in 
    match list with
    | [] -> [[]]
    | hd::tl -> List.flatten (List.map (fun xs -> insertAll hd xs)(permutation tl));;


(* zadanie 5 *)
let rec sufixes list = 
    match list with
    | [] -> [[]]
    | hd::tl -> list::(sufixes tl);;

let prefixes list = 
    List.map List.rev (sufixes (List.rev list));;


(* zadanie 6 *)

type 'a clist = { clist : 'z. ('a -> 'z -> 'z) -> 'z -> 'z};;

let cnil = {clist = fun f z -> z};;  

let ccons c cl = {clist = fun f z -> f c (cl.clist f z) };; 

let map g cl = {clist = fun f z -> cl.clist (fun a -> f (g a)) z };;

let append cl1 cl2 = {clist = fun f z -> cl1.clist f (cl2.clist f z)};;

let clist_to_list cl = cl.clist (fun x y -> x::y) [];;

let rec clist_of_list xs =
    match xs with
    | [] -> cnil
    | hd::tl -> ccons hd (clist_of_list tl);;

let prod cl1 cl2 = {clist = fun f z -> cl1.clist (fun a -> cl2.clist (fun b -> f (a, b))) z};;

