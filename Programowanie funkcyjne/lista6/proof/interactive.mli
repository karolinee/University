open Logic
open Proof

type status

val status : unit -> status


val qed : unit -> theorem


val numGoals : unit -> int


val goals : unit -> goalDesc list


val proof : context -> formula -> unit


val goal : unit -> goalDesc


val focus : int ->  unit


val unfocus : unit -> unit


val next : unit -> unit
val prev : unit -> unit


val intro : string -> unit


val apply : formula -> unit


val apply_thm : theorem -> unit

val apply_assm : string -> unit

val pp_print_status : Format.formatter -> status -> unit