open Logic

type context = (string * formula) list
type goalDesc = context * formula

type proof
type goal

(** Zamienia ukończony dowód na twierdzenie *)
val _qed : proof -> theorem

(** Zwraca liczbę pozostałych w dowodze celów (0 <-> dowód jest gotowy i można go zakończyć) *)
val _numGoals : proof -> int

(** Zwraca listę celów w danym dowodzie *)
val _goals : proof -> goalDesc list


(** Tworzy pusty dowód podanego twierdzenia *)
val _proof : context -> formula -> proof

(** Zwraca (assm, phi), gdzie assm oraz phi to odpowiednio dostępne
    założenia oraz formuła do udowodnienia w aktywnym podcelu *)
val _goal : goal -> goalDesc

(** Ustawia aktywny cel w danym dowodzie *)
val _focus : int -> proof -> goal

(** Zapomina informację o celu *)
val _unfocus : goal -> proof

(** Zmienia (cyklicznie) aktywny cel na następny/poprzedni *)
val _next : goal -> goal
val _prev : goal -> goal

(** Wywołanie intro name pf odpowiada regule wprowadzania implikacji.
  To znaczy aktywna dziura wypełniana jest regułą:

  (nowy aktywny cel)
   (name,ψ) :: Γ ⊢ φ
   -----------------(→I)
       Γ ⊢ ψ → φ

  Jeśli aktywny cel nie jest implikacją, wywołanie kończy się błędem *)
val _intro : string -> goal -> goal

(** Wywołanie apply ψ₀ pf odpowiada jednocześnie eliminacji implikacji
  i eliminacji fałszu. Tzn. jeśli do udowodnienia jest φ, a ψ₀ jest
  postaci ψ₁ → ... → ψn → φ to aktywna dziura wypełniana jest regułami
  
  (nowy aktywny cel) (nowy cel)
        Γ ⊢ ψ₀          Γ ⊢ ψ₁
        ----------------------(→E)  (nowy cel)
                ...                   Γ ⊢ ψn
                ----------------------------(→E)
                            Γ ⊢ φ

  Natomiast jeśli ψ₀ jest postaci ψ₁ → ... → ψn → ⊥ to aktywna dziura
  wypełniana jest regułami

  (nowy aktywny cel) (nowy cel)
        Γ ⊢ ψ₀          Γ ⊢ ψ₁
        ----------------------(→E)  (nowy cel)
                ...                   Γ ⊢ ψn
                ----------------------------(→E)
                            Γ ⊢ ⊥
                            -----(⊥E)
                            Γ ⊢ φ *)
val _apply : formula -> goal -> goal

(** Wywołanie `apply_thm thm pf` działa podobnie do
    `apply (Logic.consequence thm) pf`, tyle że aktywna dziura od razu
   jest wypełniana dowodem thm, a otrzymane drzewo nie jest
   sfokusowane na żadnym z celów.
*)

val _apply_thm : theorem -> goal -> goal

(** Wywołanie `apply_assm name pf` działa tak jak
    `apply (Logic.by_assumption f) pf`, gdzie f jest założeniem o
    nazwie name
 *)
val _apply_assm : string -> goal -> goal

val pp_print_proof : Format.formatter -> proof -> unit
val pp_print_goal  : Format.formatter -> goal -> unit
