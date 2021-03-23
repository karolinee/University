{-# LANGUAGE GADTs, LambdaCase #-}
import Data.Char

--zad1
int :: (String -> a) -> String -> Integer -> a
int cont s n = cont (s ++ show n)

str :: (String -> a) -> String -> String -> a
str cont s1 s2 = cont (s1 ++ s2)

lit :: String -> (String -> a) -> String -> a
lit s cont s1 = cont (s1++s)

(^^)::((String -> b) -> String -> c) -> ((String -> a) -> String -> b) -> (String -> a) -> String -> c 
(^^) f1 f2 x = f1 (f2 x) 
        
sprintf1 f = f id ""  

--zad2
data Format a b where
    Int     :: Format a (Integer -> a)
    Str     :: Format a (String -> a)
    Lit     :: String -> Format a a
    (:^:)   :: Format d b -> Format a d -> Format a b

ksprintf :: Format a b  -> (String -> a) -> b
ksprintf Int cont = cont . show
ksprintf Str cont = cont
ksprintf (Lit s) cont = cont s
ksprintf (f1 :^: f2) cont = ksprintf f1 (\s -> ksprintf f2 (\x -> cont (s++x)))

sprintf :: Format String b -> b
sprintf f = ksprintf f id

kprintf :: Format a b -> (IO () -> a) -> b
kprintf Int cont = cont . putStr . show 
kprintf Str cont = cont . putStr 
kprintf (Lit s) cont = cont (putStr s)
kprintf (f1 :^: f2) cont = kprintf f1 (\s -> kprintf f2 (\x -> cont (s>>x)))

printf :: Format (IO ()) b -> b
printf f = kprintf f id

--zad3


echoLower :: IO ()
echoLower = do x <- getChar 
               if x == '\EOT' then
                   return ()
               else
                   do putChar (toLower x)
                      echoLower 
                   
data StreamTrans i o a 
    = Return a
    | ReadS (Maybe i -> StreamTrans i o a)
    | WriteS o (StreamTrans i o a)

stoLower :: StreamTrans Char Char ()
stoLower = ReadS (\case
                    Just a -> WriteS (toLower a) stoLower
                    Nothing -> Return ())

runIOStreamTrans :: StreamTrans Char Char a -> IO a
runIOStreamTrans (Return a) = return a
runIOStreamTrans (WriteS s cont) = 
    do putChar s
       runIOStreamTrans cont
runIOStreamTrans (ReadS cont) = 
    do x <- getChar 
       if x == '\EOT' then
           runIOStreamTrans (cont Nothing)
       else
           runIOStreamTrans (cont (Just x))

--zad5
listTrans :: StreamTrans i o a -> [i] -> ([o], a)
listTrans (Return a) _ = ([], a)
listTrans (ReadS f) [] = listTrans (f Nothing) []
listTrans (ReadS f) (hd:tl) = listTrans (f (Just hd)) tl
listTrans (WriteS s cont) l = let (res, a) = listTrans cont l in (s:res, a)
