type formula = Var of string | False | Imp of formula * formula

let rec string_of_formula f =
  match f with 
  | False -> "⊥ "
  | Var s -> s
  | Imp (Imp (_, _) as l, r) -> "(" ^ string_of_formula l ^ ") -> " ^ string_of_formula r
  | Imp (l, r) -> string_of_formula l ^ " -> " ^ string_of_formula r

let pp_print_formula fmtr f =
  Format.pp_print_string fmtr (string_of_formula f)


type theorem = Theorem of formula list * formula
let assumptions (Theorem (a, _)) = a
let consequence (Theorem (_, c)) = c

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
  Theorem ([f], f)

let imp_i f thm =
  Theorem (List.filter (fun x -> x <> f) (assumptions thm), Imp(f, consequence thm))

let imp_e th1 th2 =
  match consequence th1 with
  | Imp (l, r) -> if l = (consequence th2) then Theorem (List.append (assumptions th1) (assumptions th2), r) else failwith "błąd"
  | _ -> failwith "błąd"

let bot_e f thm =
  match consequence thm with
  | False -> Theorem ((assumptions thm), f)
  | _ -> failwith "błąd"
