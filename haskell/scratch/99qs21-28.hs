module Questions2128
where

--question 21
--insertat ::  a -> [a] -> Num -> [a]
--I need to learn how to declare functions so bad

insertat e list 1 = (e:list)
insertat e (x:xs) n = x:(insertat e xs (n-1))

--question 22
range a b
  | a == b = [a]
  | otherwise = a:(range (a+1) b)

--skipping all the questions on randomness as advised

--question 26
combinations 0 _  = [[]]
combinations _ [] = []
combinations n (x:xs)
  | n <= (length (x:xs)) = (map ((:) x) (combinations (n-1) xs)) ++ (combinations n xs)
  | otherwise = []

--question 27a
--generate all ways to group 9 items into 3 disjoint subsets (group sizes 2,3,4 in that order)
--(ordering within groups doesn't matter)