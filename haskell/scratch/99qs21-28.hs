

module Questions2128 where
import Data.List

--question 21
insertat :: (Eq b, Num b) => a -> [a] -> b -> [a]
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
combinations n (x:xs) = (map ((:) x) (combinations (n-1) xs)) ++ (combinations n xs)

--question 27a
--generate all ways to group 9 items into 3 disjoint subsets (group sizes 2,3,4 in that order)
--(ordering within groups doesn't matter)

--question 28a sort lists by length
{-
quicksort implementation
lsort [] = []
lsort (x:xs) = (lsort (filter (\y -> (length y) < (length x)) xs)) ++ x : (lsort (filter (\y -> (length y) >= (length x)) xs))
-}
--using List module (copied from answers) fun fact the type declaration is necessary
lsort :: [[a]] -> [[a]]
lsort = Data.List.sortBy (\x y -> compare (length x) (length y))

--question 28b sort lists by frequency of their length.
--This method seems bad.

rle (x:xs) = rle' xs [([x],1)]
  where
    rle' [] acc = reverse acc
    rle' (x:xs) (y:ys)
      | length x == length (head (fst y)) = rle' xs ((x:(fst y), (snd y) + 1):ys)
      | otherwise = rle' xs (([x], 1):y:ys)

lfsort x = concatMap fst (Data.List.sortBy (\x y -> compare (snd x) (snd y)) (rle (lsort x)))
