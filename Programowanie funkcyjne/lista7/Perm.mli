(** zadanie 1 *)
module type OrderedType = sig
    type t
    val compare : t -> t -> int
end

module type S = sig
    type key
    type t
    (** permutacja jako funkcja *)
    val apply : t -> key -> key
    (** permutacja identycznościowa *)
    val id : t
    (** permutacja odwrotna *)
    val invert : t -> t
    (** permutacja która tylko zamnienia dwa elementy miejscami *)
    val swap : key -> key -> t
    (** złożenie permutacji (jako złożenie funkcji) *)
    val compose : t -> t -> t 
    (** porównanie permutacji *)
    val compare : t -> t -> int
end

module Make(Key : OrderedType) : S with type key = Key.t

(** zadanie 2 *)
module type S2 = sig
    type t
    val is_generated : t -> t list -> bool
end

module MakeFunction(Perm : S) : S2 with type t = Perm.t


(** zadanie 3 *)
module OrderedList (X: OrderedType) : OrderedType with type t = X.t list

module OrderedPair (X: OrderedType) : OrderedType with type t = (X.t * X.t)

module OrderedOption (X: OrderedType) : OrderedType with type t = X.t option


