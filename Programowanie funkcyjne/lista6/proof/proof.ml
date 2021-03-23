open Logic

type context = (string * formula) list
type goalDesc = context * formula


type proof = Leaf of theorem | 
             NodeU of proof * (theorem -> theorem) | 
             NodeB of proof * proof * (theorem -> theorem -> theorem) | 
             Hole of goalDesc 


type path = Top | 
            Unary of (theorem-> theorem) * path | 
            Left of (theorem -> theorem -> theorem) * path * proof |
            Right of proof * path * (theorem -> theorem -> theorem)
type goal = Goal of proof * path

let rec _qed pf =
  match pf with
  | Leaf th -> th
  | NodeB (p1, p2, f) -> f (_qed p1) (_qed p2) 
  | NodeU (p1, f) -> f (_qed p1)
  | Hole _ -> failwith "nie można zbudować twierdzenia z częściowego dowodu"

let rec _numGoals pf =
  match pf with
  | Leaf _ -> 0
  | NodeB (p1, p2, _) -> _numGoals p1 + _numGoals p2
  | NodeU (p1, _) -> _numGoals p1
  | Hole _ -> 1

let rec _goals pf =
  match pf with
  | Leaf _ -> []
  | NodeB (p1, p2, _) -> (_goals p1) @ (_goals p2)
  | NodeU (p1, _) -> _goals p1
  | Hole gD -> [gD]

let _proof g f =
  Hole(g, f) 

let _goal pf =
  match pf with
  | Goal (Hole(gD), _) -> gD
  | _ -> failwith "goal nie jest poprawny"


let go_left (Goal(pf, path)) =
  match path with 
  | Top                     -> failwith "left of Top"
  | Unary (_, _)            -> failwith "left of Unary"
  | Left (_,_,_)            -> failwith "left of Left"
  | Right (left, father, f) -> Goal(left, Left(f,father, pf))

let go_right (Goal(pf, path)) =
  match path with 
  | Top                     -> failwith "right of Top"
  | Unary (_, _)            -> failwith "right of Unary"
  | Left (f, father, right) -> Goal(right, Right(pf, father, f))
  | Right (_,_,_)           -> failwith "right of Right"

let go_up (Goal(pf, path)) = 
  match path with 
  | Top                     -> failwith "up of Top"
  | Unary (f, father)       -> Goal(NodeU (pf,f), father)
  | Left (f, father, right) -> Goal(NodeB (pf, right, f), father)
  | Right (left, father, f) -> Goal(NodeB (left, pf, f), father)

let go_down (Goal(pf, path)) = 
  match pf with
  | Leaf th             -> failwith "down of Leaf"
  | Hole gD             -> failwith "down of Hole"
  | NodeU (pf1, f)      -> Goal(pf1, Unary(f,path))
  | NodeB (pf1, pf2, f) -> Goal(pf1, Left(f, path, pf2))

let go_down_right (Goal(pf, path)) = 
  match pf with
  | Leaf th             -> failwith "down of Leaf"
  | Hole gD             -> failwith "down of Hole"
  | NodeU (pf1, f)      -> Goal(pf1, Unary(f,path))
  | NodeB (pf1, pf2, f) -> Goal(pf2, Right(pf1, path, f))

let rec forward (Goal(pf, path) as g) = 
  let rec go_up_up (Goal(pf0, path0) as gl) = (* idzie do góry aż path nie będzie top lub left *)
    match path0 with 
    | Left (f, father, right) -> go_right gl
    | Top                     -> forward gl
    | _                       -> go_up_up (go_up gl)
  in match pf with 
  | Leaf _ | Hole _   -> go_up_up g
  | NodeU (_,_)       -> go_down g
  | NodeB (_,_,_)     -> go_down g

let backward (Goal(pf, path) as g) = 
  let rec go_down_down (Goal(pf0, path0) as gl) = 
    match pf0 with 
    | NodeU (_,_) -> go_down_down (go_down gl)
    | NodeB (_,_,_) -> go_down_down (go_down_right gl)
    | _ -> gl
  in match path with
  | Top           -> go_down_down g
  | Unary (_, _)  -> go_up g
  | Left (_,_,_)  -> go_up g
  | Right (_,_,_) -> go_down_down (go_left g)

let _next (Goal(pf, path) as gl) =
  let rec aux (Goal(pf0, path0) as g)=
    match pf0 with
    | Hole _ -> g
    | _      -> aux (forward g)
  in aux (forward gl)

let _prev (Goal(pf, path) as gl) =
  let rec aux (Goal(pf0, path0) as g)=
    match pf0 with
    | Hole _ -> g
    | _      -> aux (backward g)
  in aux (backward gl)


let find_first pf =
  let rec aux g = 
    match g with
    | Goal(Hole _, _) -> g
    | _ -> aux(forward g)
  in aux (Goal(pf, Top))

let _focus n pf =
  let rec aux n gl = 
    if n = 0 then gl
    else aux (n-1) (_next gl)
  in aux n (find_first pf)

let rec _unfocus (Goal(pf, path) as gl) =
  match path with
  | Top -> pf
  | _ -> _unfocus (go_up gl)


let _intro name (Goal(pf, path)) =
  match pf with
  | Hole(cont, Imp(f1, f2)) -> 
    let nhole = Hole((name, f1)::cont, f2) in Goal(nhole, Unary(imp_i f1, path))
  | _ -> failwith "cel nie jest implikacją"

let rec _apply f (Goal(Hole(cont, form), path) as gl) =
  if f = form then gl else
  match f with
  | False -> let nhole = Hole(cont, False) in Goal(nhole, Unary(bot_e form, path))
  | Imp(f1, f2) -> let nhole = Hole(cont, f) in 
                   let nholer = Hole(cont, f1) in 
                   let Goal(nproof, npath) = (_apply f2 gl) in
                   Goal(nhole, Left(imp_e, npath, nholer))
  | _ -> failwith "błędna operacja apply"

let _apply_thm thm (Goal(Hole(cont, form), path) as gl) =
  let f = consequence thm in
  let Goal(Hole(cont0, form0), path0) = _apply f gl in
  if f = form0 then (Goal((Leaf(thm)), path0))
  else failwith "błędnie apply thm/assm"

let _apply_assm name (Goal(Hole(cont, form), path) as gl) =
  let f = List.assoc name cont in
  _apply_thm (by_assumption f) gl

let pp_print_proof fmtr pf =
  let ngoals = _numGoals pf
  and goals = _goals pf
  in if ngoals = 0
  then Format.pp_print_string fmtr "No more subgoals"
  else begin
      Format.pp_open_vbox fmtr (-100);
      Format.pp_open_hbox fmtr ();
      Format.pp_print_string fmtr "There are";
      Format.pp_print_space fmtr ();
      Format.pp_print_int fmtr ngoals;
      Format.pp_print_space fmtr ();
      Format.pp_print_string fmtr "subgoals:";
      Format.pp_close_box fmtr ();
      Format.pp_print_cut fmtr ();
      goals |> List.iteri (fun n (_, f) ->
       Format.pp_print_cut fmtr ();
       Format.pp_open_hbox fmtr ();
       Format.pp_print_int fmtr (n + 1);
       Format.pp_print_string fmtr ":";
       Format.pp_print_space fmtr ();
       pp_print_formula fmtr f;
       Format.pp_close_box fmtr ());
      Format.pp_close_box fmtr ()
    end

let pp_print_goal fmtr gl =
  let (g, f) = _goal gl
  in
  Format.pp_open_vbox fmtr (-100);
  g |> List.iter (fun (name, f) ->
      Format.pp_print_cut fmtr ();
      Format.pp_open_hbox fmtr ();
      Format.pp_print_string fmtr name;
      Format.pp_print_string fmtr ":";
      Format.pp_print_space fmtr ();
      pp_print_formula fmtr f;
      Format.pp_close_box fmtr ());
  Format.pp_print_cut fmtr ();
  Format.pp_print_string fmtr (String.make 40 '=');
  Format.pp_print_cut fmtr ();
  pp_print_formula fmtr f;
  Format.pp_close_box fmtr ()
