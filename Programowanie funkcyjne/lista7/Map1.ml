type ('a, _) order1 =
| Lt : ('a, 'b) order1
| Eq : ('a, 'a) order1
| Gt : ('a, 'b) order1

module type Type1 = sig
    type 'a t
end

module type OrderedType1 = sig
    include Type1
    val compare : 'a t -> 'b t -> ('a, 'b) order1
end

module type S = sig
    type 'a key 
    type 'a value
    type t
    val empty  : t
    val add    : 'a key -> 'a value -> t -> t
    val remove : 'a key -> t -> t
    val find   : 'a key -> t -> 'a value
end

module Make(Key : OrderedType1)(Value : Type1) = struct
    type 'a key = 'a Key.t
    type 'a value = 'a Value.t
   
    type ex_key =
    | Key : 'a key -> ex_key

    type key_value_pair =
    | KeyVal : 'a key * 'a value -> key_value_pair

    module ExKey = struct
        type t = ex_key
        let compare e1 e2 = 
            match e1, e2 with
            | Key arg1, Key arg2 -> 
                match Key.compare arg1 arg2 with 
                | Eq -> 0
                | Lt -> -1
                | Gt -> 1
    end
    
    module ExMap = Map.Make(ExKey)
    
    type t = key_value_pair ExMap.t

    let empty = ExMap.empty

    let add k1 v1 m =
        ExMap.add (Key k1) (KeyVal (k1, v1)) m
        
    let remove k1 m = 
        ExMap.remove (Key k1) m

    let find (type a) (k: a key) (m: t) : a value =
        let res = ExMap.find (Key k) m in
        match res with 
        | KeyVal (kk, vv) -> match Key.compare k kk with
            | Eq -> vv
            | _ -> failwith("noooo") 


end