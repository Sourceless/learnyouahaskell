-- Higher Order Functions:
--   - functions can take functions as parameters
--   - defining feature of haskell
--   - powerful way of solving problems and thinking about programs

-- Curried Functions:
--   - every function only takes one parameter
--   - functions that 'take more than one parameter'
--   - max 4 5 and (max 4) 5 are equivalent
--   - max :: (Ord a) => a -> a -> a is identical to
--     max :: (Ord a) => a -> (a -> a)
--     i.e. given a max retuns a function that takes a and returns a
--   - if you call a function without all its parameters you get
--     back a partially applied function
--   - putting a space between two things is function application

mutlthree :: (Num a) => a -> a -> a -> a
multthree x y z = x * y * z

--   - each argument applied in turn to each component function
--   - by calling functions with too few parameters you're creating
--     new, partial functions on the fly

compareWithHundred :: (Num a, Ord a) => a -> Ordering
compareWithHundred x = compare 100 x

--   - the above can be rewritten as:

compareWithHundred :: (Num a, Ord a) => a -> Ordering
compareWithHundred = compare 100

--   - infix functions can be partially applied using sections
--   - to do this simply surround the infix function with parens

divideByTen :: (Floating a) => a -> a
divideByTen = (/10)

isUpperAlphanum :: Char -> Bool
isUpperAlphanum = (`elem` ['A'..'Z'])

-- Higher Order Functions

applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

--   - before in the type declaration, parens were not needed
--     because -> is naturally right-associative
--   - they're mandatory here because they indicate the first
--     parameter is a function.

zipwith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

--   - the first parameter to this function is a function that takes
--     two paramaters of type a and b and retuns one of type c, the
--     second and third are lists of type a and b, and returned is a list
--     containing type c

flip' :: (a -> b -> c) -> (b -> a -> c)
flip' f = g
    where g x y = f y x

--   - takes a function a on b, returns a function b on a
--   - the second set of parentheses aren't needed as -> is right-associative

flip'' :: (a -> b -> c) -> b -> a -> c
flip'' f y x = f x y

-- Maps and Filters
--   - map takes a function and a list and applies the function to every item
--     of the list

map'' :: (a -> b) -> [a] -> [b]
map'' _ [] = []
map'' f (x:xs) = f x : map f xs

--  - these can also be achieved using a list comprehension
--  - map is more readable for cases when you only apply a function to a list
--  - filter takes a predicate and a list and returns a list where all the
--    items satisfy the predicate

filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter p (x:xs)
    | p x       = x : filter p xs
    | otherwise = filter p xs

--  - quicksort can be implemented more simply with filter

quicksort :: (Ord a_ => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
    let smallerSorted = quicksort (filter (<=x) xs)
        biggerSorted = quicksort (filter (>x) xs)
    in smallerSorted ++ [x] ++ biggerSorted

    -- to be continued!
