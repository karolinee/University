open Logic;;
open Proof;;
open Interactive;;

#install_printer Logic.pp_print_theorem;;
#install_printer Logic.pp_print_formula;;
#install_printer Proof.pp_print_goal;;
#install_printer Proof.pp_print_proof;;
#install_printer Interactive.pp_print_status;;

let p = Var "p";;
let q = Var "q";;
let r = Var "r";;

let p = Imp(p,Imp(Imp(p, q), q));;