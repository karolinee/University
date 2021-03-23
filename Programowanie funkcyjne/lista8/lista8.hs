--zadanie 1
notDivisable :: [Integer] -> [Integer]
notDivisable [] = []
notDivisable (hd:tl) = [x| x <- tl, x `mod` hd /= 0]

primes :: [Integer]
primes = map head (iterate notDivisable [2..])

--zadanie 2
primes' :: [Integer]
primes' = 2:[p| p <- [3..], all (\q -> p `mod` q /= 0) (takeWhile (\q -> q^2 <= p) primes')]


--zadanie 3
permi, perms::[a] -> [[a]]

permi [] = [[]]
permi (hd:tl) = concatMap (insert hd) (permi tl) where
    insert:: a -> [a] -> [[a]]
    insert x [] = [[x]]
    insert x (hd:tl) = (x:hd:tl) : [ hd:xs | xs <- insert x tl]

perms [] = [[]]
perms list = [x:ys|(x, xs) <- select list, ys <- perms xs ] where 
    select :: [a] -> [(a,[a])]
    select [] = []
    select (hd:tl) = (hd, tl):[(x, hd:xs)|(x,xs) <- select tl]

--zadanie 4
sublist :: [a] -> [[a]]
sublist [] = [[]]
sublist (hd:tl) = let tmp = sublist tl in
    [hd:xs|xs <- tmp] ++ tmp

--zadanie 5
qsortBy :: (a -> a -> Bool) -> [a] -> [a]
qsortBy _ [] = []
qsortBy f (hd:tl) = qsortBy f [x| x <- tl, not (f hd x)] ++ [hd] ++ qsortBy f [x| x <- tl, f hd x]

--zadanie 6
(><) :: [a] -> [b] -> [(a,b)]
(><) l1 l2 = 
    [((l1 !! (fst x)),(l2 !! (snd x))) | x <- (f l1 l2)] where
        f :: [a] -> [b] -> [(Int, Int)]
        f xs ys = [x | n <- takeWhile (\n -> not (null (drop (n-1) xs))) [1..], x <- prod (take n xs) (take n ys), (fst x) + (snd x) == n-1] where
            prod :: [a] -> [b] -> [(Int, Int)]
            prod xs ys = [(x, y) | x <- [0..(length xs)-1], y <- [0..(length ys)-1]]

--zadanie 7
data Tree a = Node (Tree a) a (Tree a) | Leaf deriving (Eq, Show)
data Set a = Fin (Tree a) | Cofin (Tree a) deriving (Eq, Show)

setFromList::Ord a => [a] -> Set a
setEmpty, setFull :: Ord a => Set a
setUnion, setIntersection :: Ord a => Set a -> Set a -> Set a
setComplement :: Ord a => Set a -> Set a
setMember :: Ord a => a -> Set a -> Bool

setFromList xs = Fin (treeFromList xs)

treeFromList :: Ord a => [a] -> Tree a
treeFromList [] = Leaf
treeFromList (hd:tl) = Node (treeFromList [x|x<-tl, x < hd]) hd (treeFromList [x|x<-tl, x > hd])

setEmpty = Fin Leaf
setFull = Cofin Leaf

setMember x (Fin tree) = treeMember x tree where 
    treeMember:: Ord a => a -> Tree a -> Bool
    treeMember _ Leaf = False
    treeMember x (Node l elem r) 
        | elem == x = True
        | elem < x  = treeMember x l
        | otherwise   = treeMember x r
setMember x (Cofin tree) = not (setMember x (Fin tree))

setComplement (Fin tree) = Cofin tree
setComplement (Cofin tree) = Fin tree

treeToList::Ord a => Tree a -> [a]
treeToList Leaf = []
treeToList (Node l elem r) = elem : (treeToList l) ++  (treeToList r)

setUnion (Fin tree1) (Fin tree2) = setFromList ((treeToList tree1)++(treeToList tree2))
setUnion (Fin tree1) (Cofin tree2) = Cofin (treeFromList [x| x<-(treeToList tree2), all (\y -> x/=y) (treeToList tree1)])
setUnion (Cofin tree2) (Fin tree1) = setUnion (Fin tree1) (Cofin tree2)
setUnion (Cofin tree1) (Cofin tree2) = Cofin (treeFromList [x| x<-(treeToList tree2), any (\y -> x==y) (treeToList tree1)])

setIntersection (Fin tree1) (Fin tree2) = setFromList [x| x<-(treeToList tree1), any (\y -> x==y) (treeToList tree2)]
setIntersection (Fin tree1) (Cofin tree2) = Fin (treeFromList [x| x<-(treeToList tree1), all (\y -> x/=y) (treeToList tree2)])
setIntersection (Cofin tree2) (Fin tree1) = setIntersection (Fin tree1) (Cofin tree2)
setIntersection (Cofin tree1) (Cofin tree2) = Cofin (treeFromList $ (treeToList tree1)++(treeToList tree2))



