import Control.Monad
--zad1
class Monad m => Random m where
    random :: m Int

shuffle :: Random m => [a] -> m [a]
shuffle [] = return []
shuffle xs = do idx <- random
                rest <- shuffle (remove (idx `mod` length xs) xs)
                return (xs !! (idx `mod` length xs):rest)
                where remove :: Int -> [a] -> [a]
                      remove idx xs = let (first, second) = splitAt idx xs in first ++ drop 1 second


--zad2
newtype RS a = RS {unRS :: Int -> (Int, a)}

instance Functor RS where
    fmap = liftM

instance Applicative RS where
    pure = return
    (<*>) = ap

instance Monad RS where
    return x = RS (\y -> (y, x))
    RS a >>= f = RS (\x -> let (world, val) = a x in let RS tmp = f val in tmp world)

instance Random RS where
    random = RS (\x -> let b = 16807 * (x `mod` 127773) - 2836 * (x `div` 127773) in 
                    if b > 0 then
                        (b, b)
                    else
                        (b + 2147483647, b + 2147483647)) 

withSeed :: RS a -> Int -> a
withSeed (RS a) x = snd (a x)