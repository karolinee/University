type formula = Var of string | False | Imp of formula * formula

let rec string_of_formula f =
  match f with 
  | False -> "⊥ "
  | Var s -> s
  | Imp (Imp (_, _) as l, r) -> "(" ^ string_of_formula l ^ ") -> " ^ string_of_formula r
  | Imp (l, r) -> string_of_formula l ^ " -> " ^ string_of_formula r
  

let pp_print_formula fmtr f =
  Format.pp_print_string fmtr (string_of_formula f)

type theorem =  Ax of formula list * formula 
              | ImpI of theorem * (formula list * formula)
              | ImpE of theorem * theorem * (formula list * formula)
              | FalseE of theorem * (formula list * formula)

let assumptions thm =
  match thm with
  | Ax (f_list, _) -> f_list  
  | ImpI (_ , (f_list, _)) -> f_list
  | ImpE (_, _ , (f_list, _)) -> f_list
  | FalseE (_, (f_list, _)) -> f_list

let consequence thm =
  match thm with
  | Ax (_, f) -> f  
  | ImpI (_ , (_, f)) -> f
  | ImpE (_, _ , (_, f)) -> f
  | FalseE (_, (_, f)) -> f

let pp_print_theorem fmtr thm =
  let open Format in
  pp_open_hvbox fmtr 2;
  begin match assumptions thm with
  | [] -> ()
  | f :: fs ->
    pp_print_formula fmtr f;
    fs |> List.iter (fun f ->
      pp_print_string fmtr ",";
      pp_print_space fmtr ();
      pp_print_formula fmtr f);
    pp_print_space fmtr ()
  end;
  pp_open_hbox fmtr ();
  pp_print_string fmtr "⊢";
  pp_print_space fmtr ();
  pp_print_formula fmtr (consequence thm);
  pp_close_box fmtr ();
  pp_close_box fmtr ()

let by_assumption f =
  Ax ([f], f)

let imp_i f thm =
  ImpI (thm, (List.filter (fun x -> x <> f) (assumptions thm) , Imp (f, consequence thm)))

let imp_e th1 th2 =
  match consequence th1 with
  | Imp (l, r) -> if l = (consequence th2) then ImpE (th1, th2, (List.append (assumptions th1) (assumptions th2), r)) else failwith "błąd"
  | _ -> failwith "błąd"
  
let bot_e f thm =
  match consequence thm with
  | False -> FalseE (thm, ((assumptions thm), f))
  | _ -> failwith "błąd"
