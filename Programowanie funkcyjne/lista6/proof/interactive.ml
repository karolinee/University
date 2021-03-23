open Logic
open Proof

type status = ProofStatus of proof | GoalStatus of goal | Empty;;

let status, getStatus =
  let currentStatus = ref Empty in
  ( (fun () -> !currentStatus), (fun () -> currentStatus));;  

let unpackProof (st: status) =
  match st with
  | ProofStatus pf -> pf
  | _ ->  failwith("cant unpack proof");;

let unpackGoal (st: status) =
  match st with
  | GoalStatus gl -> gl
  | _ ->  failwith("cant unpack goal");;

let qed () =
    let _status = getStatus ()
        in let res = _qed (unpackProof (!_status))
            in _status := Empty; res

      
let goals () = 
    _goals (unpackProof (status ()))

let numGoals () =
  List.length (goals ())

let proof g f =
    let _status = getStatus () 
        in _status := ProofStatus(_proof g f)

let goal () = 
    _goal (unpackGoal (status ()))

let next () = 
    let _status = getStatus () 
        in let res = _next (unpackGoal (!_status))
            in _status := GoalStatus(res)

let prev () = 
    let _status = getStatus () 
        in let res = _prev (unpackGoal (!_status))
            in _status := GoalStatus(res)

let focus n = 
    let _status = getStatus () 
        in let res = _focus n (unpackProof (!_status))
            in _status := GoalStatus(res)

let unfocus n = 
    let _status = getStatus () 
        in let res = _unfocus (unpackGoal (!_status))
            in _status := ProofStatus(res)

let intro name = 
    let _status = getStatus () 
        in let res = _intro name (unpackGoal (!_status))
            in _status := GoalStatus(res)

let apply f =
    let _status = getStatus () 
        in let res = _apply f (unpackGoal (!_status))
            in _status := GoalStatus(res)

let apply_thm thm =
    let _status = getStatus () 
        in let res = _apply_thm thm (unpackGoal (!_status))
            in _status := GoalStatus(res); unfocus ()

let apply_assm name =
    let _status = getStatus () 
        in let res = _apply_assm name (unpackGoal (!_status))
            in _status := GoalStatus(res); unfocus ()


let pp_print_status fmtr st = 
    match st with
    | ProofStatus pf -> 
        let ngoals = numGoals ()
        and goals = goals ()
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
    | GoalStatus gs -> 
        let (g, f) = goal ()
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
    | Empty -> Format.pp_print_string fmtr "There is no active proof"
