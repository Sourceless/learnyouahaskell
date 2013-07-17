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

--  - map and filter are an important part of the programmer's toolbox
--  - even if you map over something several times, thanks to Haskell's
--    laziness, it'll really only happen once.

largestDivisible :: (Integral a) => a
largestDivisible = head (filter p [100000,99999..])
    where p x = x `mod` 3829 == 0

--  - the list doesn't even need to be finite
--  - this is due to haskell's laziness - the evaluation just stops when
--    an adequate solution is found.
--  - takeWhile takes items from a list with a predicate is met
--  - useful for working with infinite lists because of this
--  - collatz sequences: take a natural number, if it's even, divide by 2,
--    else, times by three and add one. The chain finishes at 1.

chain :: (Integral a) => a -> [a]
chain 1 = [1]
chain n
    | even n = n:chain (n `div` 2)
    | odd n  = n:chain (n*3 + 1)

--  - now to find the number of chains longer than 15 between 1 and 100

numLongChains :: Int
numLongChains = length (filter isLong (map chain [1..100]))
    where isLong xs = length xs > 15

--  - we can define infinite lists and peek at bits of them later

-- to be continured
