
module Main1
where

{-here's a multiline comment-}

data Exp = Elem Int | Binop Exp String Exp deriving Show


eval (Elem a) = a
eval (Binop b "+" c) = (eval b) + (eval c)

perm [] = []
perm (x:[]) = [[x]]
perm l = map (\x -> perm' (head x) (tail x) (length x)) l
  where
    perm' _ _ 0 = []
--    perm' x xs n = (concatMap (\a -> x:a) ["a", "b"])
    perm' x xs n = (concatMap (\a -> x:a) (perm xs))
-- ++ (perm' (head xs) ((tail xs) ++ [x]) (n-1))