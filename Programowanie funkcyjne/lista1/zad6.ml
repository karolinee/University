type cbool = { cbool : 'a. 'a -> 'a -> 'a};;
type cnum = { cnum : 'a. ('a -> 'a) -> 'a -> 'a};;


let ctrue = { cbool = fun x y -> x };;
let cfalse = { cbool = fun x y -> y};;

let cand c1 c2 = { cbool = fun x y -> c1.cbool (c2.cbool x y) y };;
let cor c1 c2 = { cbool = fun x y -> c1.cbool x (c2.cbool x y) };;

let cbool_of_bool b = 
    if b then ctrue else cfalse;;

let bool_of_cbool c = c.cbool true false;;



let zero = { cnum = fun f x -> x};;

let succ cn = {cnum = fun f x -> f (cn.cnum f x)};;

let add cn1 cn2 = {cnum = fun f x -> cn1.cnum f (cn2.cnum f x)};;

let mul cn1 cn2 = {cnum = fun f x -> cn1.cnum (cn2.cnum f) x};;

let is_zero cn = {cbool = fun x y -> cn.cnum (fun _->y) x};;

let rec cnum_of_int n = 
    if n==0 then zero else succ (cnum_of_int (n-1));;

let int_of_cnum cn = cn.cnum (fun x -> x+1) 0;;
