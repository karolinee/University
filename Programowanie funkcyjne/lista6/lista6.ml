(* zadanie 1 *)
include Hashtbl;;
let rec fix f x = f (fix f) x;;

let fib_f fib n = 
    if n <= 1 then n
    else fib (n-1) + fib (n-2);;

let fib = fix fib_f;;

let rec fix_with_limit limit f x = 
    if limit >= 0 
    then f (fix_with_limit (limit - 1) f) x 
    else failwith("przekroczono maksymalną głębokość rekursji");;


let fix_memo f = 
    let cache = create 0 in
    let rec aux x =
        match find_opt cache x with
        | None -> let res = f aux x in add cache x res; res
        | Some arg -> arg
    in aux;;
    

(* zadanie 3 *)
let next, reset = 
    let cnt = ref 0
    in (fun () -> let r = !cnt in cnt := r + 1; r), (fun () -> cnt := 0);;


(*zadanie 4*)
type 'a stream = Stream of 'a * (unit -> 'a stream);;

let rec ltake n lxs =
  match (n, lxs) with
  | 0, _ -> []
  | n, Stream (x, xf) -> x :: ltake (n - 1) (xf ());;

let leibniz = 
    let rec aux value_so_far value sign =
        let nval = value_so_far +. ((1. /. value) *. sign *. 4.)
        in Stream(nval, (fun () -> aux nval (value +. 2.) (-.sign)))
    in aux 0. 1. 1.

let transform_stream f s = 
    let rec aux x1 x2 s =
    match s with
    | Stream(x3, xf3) -> Stream((f x1 x2 x3), (fun () -> aux x2 x3 (xf3 ())))
    in 
    match s with 
    | Stream(x1, xf1) ->
        match (xf1 ()) with
        | Stream(x2, xf2) -> aux x1 x2 (xf2 ())

let eulerTransform x y z = z -. (((y -. z)*.(y -. z))/.(x -. 2.*.y +. z))

let leibnizEuler = transform_stream eulerTransform leibniz


(*zadanie 5*)
type 'a dllist = 'a dllist_data lazy_t 
and 'a dllist_data = 
    { prev : 'a dllist
    ; elem : 'a
    ; next : 'a dllist} 

let prev dl = (Lazy.force dl).prev;;

let elem dl = (Lazy.force dl).elem;;

let next dl = (Lazy.force dl).next;; 

let of_list xs : 'a dllist =
  match xs with
  | [] -> failwith("dana lista jest pusta")
  | hd::tl ->
      let rec auxNext prev xs start : 'a dllist =
        match xs with
        | [] -> start
        | hd::tl -> let rec newNode = lazy { prev = prev; elem = hd; next = auxNext newNode tl start}
            in newNode
      and auxBack llist counter =
        match counter with 
        | [] -> (Lazy.force llist) 
        | _ :: tl -> auxBack (next llist) tl
      in let rec res = lazy { prev = lazy (auxBack res tl); elem = hd; next = auxNext res tl res}
      in res

(*zadanie 6 *)
let integers = 
    let rec auxNext prev elem = 
        let rec newNode = {prev = lazy prev; elem = elem; next = lazy (auxNext newNode (elem + 1))} 
        in newNode
    and auxBack next elem = 
        let rec newNode = {prev = lazy (auxBack newNode (elem - 1)); elem = elem; next = lazy next} 
        in newNode
    in let rec res = {prev = lazy (auxBack res (-1)); elem = 0; next = lazy (auxNext res 1)} in lazy res;;

(*zadanie 7 *)
type 'a my_lazy = {lazy_fun: (unit -> 'a); mutable value: 'a option; mutable is_calculating: bool}

let force (lval: 'a my_lazy) =
    if lval.is_calculating then
        match lval.value with
        | None -> failwith("not productive")
        | Some arg -> arg
    else
        (
            lval.is_calculating <-  true;
            let res = (lval.lazy_fun ()) 
                in lval.value <- Some res; res
        )

let rec fix (f: 'a my_lazy -> 'a) : 'a my_lazy =
    let rec res = {lazy_fun = (fun () -> f res) ; value = None; is_calculating = false} in res

type 'a lstream = Cons of 'a * ('a lstream) my_lazy
let rec my_ltake n lxs =
  match (n, force lxs) with
  | 0, _ -> []
  | n, Cons (x, xf) -> x :: my_ltake (n - 1) xf

let stream_of_ones = fix (fun stream_of_ones -> Cons(1, stream_of_ones))

let rec primes_stream n (a: 'a my_lazy) = 
    let rec check x limit =
        if x > limit then 
            Cons(n, fix (primes_stream (n+1)))
        else
        (
            if n mod x = 0 then
                primes_stream(n+1) a
            else 
                check (x+1) limit
        )
    in if n < 2 then primes_stream 2 a else check 2 (n-1)

let primes = fix (primes_stream 2);;