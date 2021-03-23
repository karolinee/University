-- zadanie 1
module QBF where

type Var = String
data Formula 
    = Var Var             -- zmienne zdaniowe
    | Bot                 -- spójnik fałszu 
    | Not Formula         -- negacja
    | And Formula Formula -- koniunkcja
    | All Var Formula     -- kwantyfikacja uniwersalna
    deriving Show

type Env = Var -> Bool
eval :: Env -> Formula -> Bool
eval env (Var p) = env p
eval _ Bot = False
eval env (Not f) = not (eval env f)
eval env (And f g) = eval env f && eval env g
eval env (All p f) = eval (\x -> (x == p) || env x) f && eval (\x -> (x /= p) && env x)  f

isTrue :: Formula -> Bool
isTrue = eval (\_ -> error "Zmienna wolna!")


--All "p" (Not (All "q" (Not (And (Not (And (Var "p") (Var "q"))) (Not (And (Not (Var "p")) (Not (Var "q"))))))))