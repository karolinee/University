(*zadanie 1*)
type 'a btree = Leaf | Node of 'a btree * 'a * 'a btree;;

let balanced tree = 
    let rec aux tree =
        match tree with
        | Leaf -> (true, 0)
        | Node (left, _ , right) -> let l_balanced, l_nodes = aux left and r_balanced, r_nodes = aux right 
        in (l_balanced && r_balanced && (abs(l_nodes - r_nodes) <= 1), l_nodes + r_nodes + 1)
    in fst (aux tree);;


let halve list =
    let rec aux acc list counter = 
        match counter with
        | [] -> (List.rev acc), list 
        | [_] -> (List.rev (List.hd list::acc)), (List.tl list)
        | hd::tail -> aux (List.hd list::acc) (List.tl list) (List.tl tail)   
    in aux [] list list;;

let rec build_balanced xs = 
    match xs with
    | [] -> Leaf
    | [x] -> Node (Leaf, x, Leaf)
    | hd::tl -> let l_halve, r_halve = halve tl 
    in Node(build_balanced l_halve, hd, build_balanced r_halve);;

(*zadanie 2*)
type 'a place = 'a list * 'a list;;

let findNth xs n :'a place=
    let rec aux l r n = 
        match n with
        | 0 -> (l, r)
        | k -> aux ((List.hd r)::l) (List.tl r) (k-1)
    in aux [] xs n;;


let collapse (p: 'a place) = List.rev_append (fst p) (snd p);;

let add x p :'a place = (fst p, x::(snd p));;

let del p :'a place = (fst p, List.tl (snd p));;

let next (p: 'a place) :'a place = 
    let before, after = p in ((List.hd after)::before, List.tl after);;

let prev (p: 'a place) :'a place = 
    let before, after = p in (List.tl before, (List.hd before)::after);;


(* zadanie 7*)
let p = Var "p";;
let q = Var "q";;
let r = Var "r";;

let k1 = imp_i p (by_assumption p);;
let k2 = imp_i p (imp_i q (by_assumption p));;

let imp_pqr = Imp (p, Imp (q, r));;
let imp_pq = Imp (p, q);;

let k3 = imp_i imp_pqr (imp_i imp_pq (imp_i p (imp_e (imp_e (by_assumption imp_pqr) (by_assumption p)) (imp_e (by_assumption imp_pq) (by_assumption p)))));;

let k4 = imp_i False (bot_e p (by_assumption False));;
