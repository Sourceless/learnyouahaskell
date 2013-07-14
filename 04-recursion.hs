-- Recursion:
--   - defining functions in terms of themselves
--   - base (edge condition) and other cases
--   - in haskell you say what something is, not how to get it

maximum' :: (Ord a) => [a] -> a
maximum' [] = error "maximum of empty list"
maximum' [x] = x
maximum' (x:xs)
    | x > maxTail = x
    | otherwise = maxTail
    where maxTail = maximum' xs

--   - can be rewritten using the max function

maximum'' :: (Ord a) => [a] -> a
maximum'' [] = error "maximum fo empty list"
maximum'' [x] = x
maximum'' (x:xs) = max x (maximum'' xs)

--   - replicate takes an int and some element and repeats that element

replicate' :: (Num i, Ord i) => i -> a -> [a]
replicate' n x
    | n <= 0    = []
    | otherwise = x:replicate' (n-1) x

--   - take takes n elements form the start of a list

take' :: (Num i, Ord i) => i -> [a] -> [a]
take' n _
    | n <= 0   = []
take' _ []     = []
take' n (x:xs) = x : take' (n-1) xs

--   - reverse simply reverses lists

reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]

--   - this doesn't really need an edge condition since haskell supports
--     infinite lists
--   - repreat takes an element and just repeats it infinitely

repeat' :: a -> [a]
repeat' x = x:repeat' x

--   - zip takes two lists and zips them together

zip' :: [a] -> [b] -> [(a,b)]
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:ys) = (x,y):zip' xs ys

--   - elem takes an element and a list and sees if it's in the list

elem' :: (Eq a) => a -> [a] -> Bool
elem' a [] = False
elem' a (x:xs)
    | a == x    = True
    | otherwise = a `elem'` xs

--   - quicksort perofrms the quicksort algorithm on a list

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
    let smallerSorted = quicksort [a | a <- xs, a <= x]
        biggerSorted = quicksort [a | a <- xs, a > x]
    in  smallerSorted ++ [x] ++ biggerSorted

-- BONUS: in which I attempt to define mergesort in haskell

merge :: (Ord a) => [a] -> [a] -> [a]
merge [] [] = []
merge xs []  = xs
merge [] ys  = ys
merge (x:xs) (y:ys)
    | y > x     = x:merge xs (y:ys)
    | otherwise = y:merge (x:xs) ys

mergesort :: (Ord a) => [a] -> [a]
mergesort [] = []
mergesort xs
    | length xs < 2 = xs
    | otherwise     = let start = take (div (length xs) 2) xs
                          end   = drop (div (length xs) 2) xs
                      in  merge (mergesort start) (mergesort end)

-- BONUS note: this took me maybe half an hour or more (getting my head 
-- round how to do it recursively using patterns and guards), but I did it!
