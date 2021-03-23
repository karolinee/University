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

module Make(Key : OrderedType) = struct
    module PermFun = Map.Make(Key)
    
    type key  = Key.t
    type t = Perm of (key PermFun.t * key PermFun.t)

    let apply (Perm(f, _)) k = 
        let res = PermFun.find_opt k f
        in match res with
        | None -> k
        | Some arg -> arg

    let id = Perm(PermFun.empty, PermFun.empty)

    let invert (Perm(f1,f2)) = Perm(f2,f1)

    let swap k1 k2 = 
        if (Key.compare k1 k2) <> 0 then
        let m = PermFun.add k1 k2 (PermFun.empty) in let m = PermFun.add k2 k1 m 
                in Perm(m, m)
        else id

    let compose (Perm(f1, f2) as t1) (Perm(g1, g2) as t2) =
        let aux perm key p1 p2 = 
            match  p1, p2 with
            | Some(x), _ -> let tmp = apply perm x in if Key.compare key tmp = 0 then None else Some(tmp)
            | None, Some(_) -> p2
            | None, None -> None
        in let m1 = PermFun.merge (aux t1) g1 f1 and m2 = PermFun.merge (aux t2) f2 g2 in Perm(m1, m2)        

    let compare (Perm(f1, _)) (Perm(f2,_)) = PermFun.compare Key.compare f1 f2
end

module type S2 = sig
    type t
    val is_generated : t -> t list -> bool
end

module MakeFunction(Perm : S) = struct
    type t = Perm.t

    module PermSet = Set.Make(Perm)

    let is_generated perm generators =
        let rec generate_set perms xs = 
            match xs with
            | [] -> PermSet.empty
            | hd::tl -> PermSet.union (PermSet.map (fun p -> Perm.compose p hd) perms) (generate_set perms tl) in
        let rec aux perms =
            let nperms = PermSet.union (PermSet.union perms (PermSet.map Perm.invert perms)) (generate_set perms (PermSet.elements perms))
            in if PermSet.compare perms nperms = 0 then match PermSet.find_opt perm perms with
            | None -> false
            | Some _ -> true
            else aux nperms
        in aux (PermSet.union (PermSet.of_list generators) (PermSet.singleton Perm.id))
end


(** zadanie 3 *)
module OrderedList (X: OrderedType) = struct
    type t = X.t list
    let compare xs ys = 
        let rec aux xs ys =
            match xs, ys with 
            | x::xs, y::ys -> let res = X.compare x y in if res = 0 then aux xs ys else res
            | hd::tl, [] -> 1
            | [], hd::tl -> -1
            | [],[] -> 0
        in aux xs ys
end

module OrderedPair (X: OrderedType) = struct
    type t = (X.t * X.t)
    let compare p1 p2 =
        let res = X.compare (fst p1) (fst p2) in
            if res = 0 then (X.compare (snd p1) (snd p2)) else res
end

module OrderedOption (X: OrderedType) = struct
    type t = X.t option
    let compare o1 o2 =
        match o1, o2 with
        | None, None -> 0
        | None, Some _ -> -1
        | Some _, None -> 1
        | Some arg1, Some arg2 -> X.compare arg1 arg2
end