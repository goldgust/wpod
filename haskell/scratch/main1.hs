
module Main1
where

data Exp = Elem Int | Binop Exp String Exp deriving (Show, Eq)

eval (Elem a) = a
eval (Binop b "+" c) = (eval b) + (eval c)
eval (Binop b "-" c) = (eval b) - (eval c)
--eval (Binop b "/" c) = (eval b) / (eval c)
eval (Binop b "*" c) = (eval b) * (eval c)

combinations 0 _  = [[]]
combinations _ [] = []
combinations n (x:xs) = (map ((:) x) (combinations (n-1) xs)) ++ (combinations n xs)

remove :: Eq a => [a] -> [a] -> [a]
remove (x:[]) list = remove' x list
  where
    remove' i [] = []
    remove' i (x:xs)
      | i == x = remove' i xs
      | otherwise = x : remove' i xs
remove (x:xs) list = remove [x] (remove xs list)

--treelayer :: [Exp] -> [[Exp]]
--treelayer elems = map (\x -> (Binop (head x) "+" ((head . tail) x)) : (remove x elems)) (combinations 2 elems)


treelayer elems = concatMap (\x ->
                                  [(Binop (head x) "+" ((head . tail) x)) : (remove x elems),
                                  (Binop (head x) "*" ((head . tail) x)) : (remove x elems),
                                  (Binop ((head . tail) x)  "-" (head x)) : (remove x elems),
                                  (Binop (head x) "-" ((head . tail) x)) : (remove x elems),
                                  (Binop ((head . tail) x)  "/" (head x)) : (remove x elems),
                                  (Binop (head x) "/" ((head . tail) x)) : (remove x elems)])
                                  (combinations 2 elems)

{-
[(Binop (head x) "+" ((head . tail) x)) : (remove x elems))] :
                  (Binop (head x) "*" ((head . tail) x)) : (remove x elems)) :
                  (Binop (head x) "-" ((head . tail) x)) : (remove x elems)) :
                  ((head . tail) x))  "-" (Binop (head x) : (remove x elems)) :
                  (Binop (head x) "/" ((head . tail) x)) : (remove x elems)) :
                  ((head . tail) x))  "-" (Binop (head x) : (remove x elems)) : [])
-}

alltrees :: [[Exp]] -> [[Exp]]
alltrees elems
  | length (head elems) == 1 = elems
  | otherwise = elems ++ alltrees (concatMap treelayer elems)

--map (map eval) (alltrees elems)