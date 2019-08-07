module Main2
where

--1
myLast [] = error "list too short"
myLast (x:[]) = x
myLast (_:xs) = myLast xs

--2
myButLast [] = error "list too short"
myButLast (_:[]) = error "list too short"
myButLast (x:_:[]) = x
myButLast (_:xs) = myButLast xs

--3
elementAt 1 (x:__) = x
elementAt n (_:xs) = elementAt (n-1) xs

--4
myLength [] = 0
myLength (_:xs) = (myLength xs) + 1

--5
myReverse a = myReverse' a []
  where
    myReverse' [] b = b
    myReverse' (x:xs) b = myReverse' xs (x:b)

--6

isPalindrome x = x == (myReverse x)

--7 (not completed)
--this is copied almost exactly from the answers
--i'm not sure why you need types for the lists
data NestedList a = Elem a | List [NestedList a] deriving Show
flatten (List []) = []
flatten (Elem a) = [a]
flatten (List (x:xs)) = (flatten x) ++ (flatten (List xs))



--8

compress [] = []
compress [x] = [x]
compress (x:y:xs)
    | x==y = compress (y:xs)
    | x/=y = [x] ++ compress (y:xs)




--9

pack a = pack' (myReverse a) []
  where
    pack' [] b = b
    pack' (x:xs) [] = pack' xs [[x]]
    pack' (x:xs) (y:ys)
      | x == (head y) = pack' xs ((x:y):ys)
      | otherwise = pack' xs ([x]:(y:ys))

--10

encode a = encode' (pack a)
  where
    encode' [] = []
    encode' (x:xs) = ((head x), (myLength x)) : (encode' xs)
