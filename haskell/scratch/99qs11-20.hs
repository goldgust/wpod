module Questions1120
where

--question 14
dupli x = concatMap (\x -> [x,x]) x

--question 15
repli n x = concatMap (\x -> replicate n x) x

--question 16
dropeverynth n list = map fst (filter (\x -> (snd x) `mod` n /= 0) (zip list [1..]))

--question 17
--this can't possibly be the best way!
split x n = split' x [] n
  where
    split' x y 0  = ((reverse y), x)
    split' (x:xs) y n = split' xs (x:y) (n-1)

--question 18
slice :: Int -> Int -> [a] -> [a]
slice _ 0 x = []
slice 1 b (x:xs) = x:(slice 1 (b-1) xs)
slice a b (_:xs) = slice (a-1) (b-1) xs

--question 19
--supposed to use length and ++ so I suppose it can be done without recursion
rotate x 0 = x
rotate (x:xs) n = rotate (xs ++ [x]) (n-1)

--question 20
dropnth _ [] = []
dropnth 1 (_:xs) = xs
dropnth n (x:xs) = x:(dropnth (n-1) xs)