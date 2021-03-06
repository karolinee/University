(** reprezentacja formuł *)
type formula = Var of string | False | Imp of formula * formula

val pp_print_formula : Format.formatter -> formula -> unit

(** reprezentacja twierdzeń *)
type theorem

(** założenia twierdzenia *)
val assumptions : theorem -> formula list
(** teza twierdzeni *)
val consequence : theorem -> formula

val pp_print_theorem : Format.formatter -> theorem -> unit

(** by_assumption f konstuuje następujący dowód

  -------(Ax)
  {f} ⊢ f  *)
val by_assumption : formula -> theorem

(** imp_i f thm konstuuje następujący dowód

       thm
      Γ ⊢ φ
 ---------------(→I)
 Γ \ {f} ⊢ f → φ *)
val imp_i : formula -> theorem -> theorem

(** imp_e thm1 thm2 konstuuje następujący dowód

    thm1      thm2
 Γ ⊢ φ → ψ    Δ ⊢ φ 
 ------------------(→E)
 Γ ∪ Δ ⊢ ψ *)
val imp_e : theorem -> theorem -> theorem

(** bot_e f thm konstruuje następujący dowód

   thm
  Γ ⊢ ⊥
  -----(⊥E)
  Γ ⊢ f *)
val bot_e : formula -> theorem -> theorem
