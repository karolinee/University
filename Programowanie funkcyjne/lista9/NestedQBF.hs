-- zadanie 2
{-# LANGUAGE LambdaCase #-}
module NestedQBF where
import Data.Void ( absurd, Void )


data Inc v = Z | S v
data Formula v
    = Var v
    | Bot
    | Not (Formula v)
    | And (Formula v) (Formula v)
    | All (Formula (Inc v))


type Env v = v -> Bool
eval :: Env v -> Formula v -> Bool
eval env (Var p) = env p
eval _ Bot = False
eval env (Not f) = not (eval env f)
eval env (And f1 f2) = eval env f1 && eval env f2
eval env (All f) = eval (\case
                        Z -> True 
                        S v -> env v) f  && 
                   eval (\case 
                        Z -> False
                        S v -> env v) f


isTrue :: Formula Void -> Bool
isTrue = eval absurd