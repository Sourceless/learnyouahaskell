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

--   - these can also be achieved using a list comprehension
--   - map is more readable for cases when you only apply a function to a list
--   - filter takes a predicate and a list and returns a list where all the
--    items satisfy the predicate

filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter p (x:xs)
    | p x       = x : filter p xs
    | otherwise = filter p xs

--   - quicksort can be implemented more simply with filter

quicksort :: (Ord a_ => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
    let smallerSorted = quicksort (filter (<=x) xs)
        biggerSorted = quicksort (filter (>x) xs)
    in smallerSorted ++ [x] ++ biggerSorted

--   - map and filter are an important part of the programmer's toolbox
--   - even if you map over something several times, thanks to Haskell's
--    laziness, it'll really only happen once.

largestDivisible :: (Integral a) => a
largestDivisible = head (filter p [100000,99999..])
    where p x = x `mod` 3829 == 0

--   - the list doesn't even need to be finite
--   - this is due to haskell's laziness - the evaluation just stops when
--    an adequate solution is found.
--   - takeWhile takes items from a list with a predicate is met
--   - useful for working with infinite lists because of this
--   - collatz sequences: take a natural number, if it's even, divide by 2,
--    else, times by three and add one. The chain finishes at 1.

chain :: (Integral a) => a -> [a]
chain 1 = [1]
chain n
    | even n = n:chain (n `div` 2)
    | odd n  = n:chain (n*3 + 1)

--   - now to find the number of chains longer than 15 between 1 and 100

numLongChains :: Int
numLongChains = length (filter isLong (map chain [1..100]))
    where isLong xs = length xs > 15

--   - we can define infinite lists and peek at bits of them later
--   - you can partially apply functions using map too

-- Lambdas:
--   - anonymous functions
--   - usually made just to be applied to a higher-order function
--   - declared using \ (because it's most of a lambda)
--   - \parameters -> function body

numLongChains' :: Int
numLongChains' = length (filter (\xs -> length xs > 15) (map chain [1..100]))

--   - lambdas are expressions too
--   - excessively simple lambdas can probably be accomplished using partial
--     application instead
--   - lambdas can take any number of parameters
--   - lambdas can pattern match
--   - due to the default currying behaviour, the below are equivalent:

addThree :: (Num a) => a -> a -> a -> a
addThree x y z = x + y + z

addThree' :: (Num a) => a -> a -> a -> a
addThree' = \x -> \y -> \z -> x + y + z

--   - but of course the first way is more readable

flip''' :: (a -> b -> c) -> b -> a -> c
flip''' f = \x y -> f y x

-- Folding:
--   - Recursive functions that reduce a list to a single value are common
--   - This is called folding
--   - A fold takes a binary function, a starting value (the accumulator),
--     and a list to fold up.
--   - The binary function is called repeatedly with the accumulator and the
--     first/last element of the list.
--   - foldl is the left fold, which takes the head of the list each time.

sum' :: (Num a) => [a] -> a
sum' xs = foldl (\acc x -> acc + x) 0 xs

--   - this can be made shorter, taking in mind what is said about lambdas earlier,
--     and the fact that a binary function is used, and that we can use partial
--     application

sum'' :: (Num a) => [a] -> a
sum'' = foldl (+) 0

--   - generally if you have something of the form
--        foo a = bar b a
--     it can be changed to
--        foo = bar b

elem' :: (Eq a) => a -> [a] -> Bool
elem' y ys = foldl (\acc x -> if x == y then True else acc) False ys

--   - the right fold, foldr, works in a similar way but in the other direction
--   - the binary function's arguemtns are the other way round, so the
--     accumulator is on the same side as the fold's name

map' :: (a -> b) -> [a] -> [b]
map' f xs = foldr (\x acc -> f x : acc) [] xs

--   - foldl1 and foldr1 are similar to their siblings, but they don't require
--     the accumulator argument - they just assume that the first element they
--     encounter to be the starting value.

sum''' :: (Num a) => [a] -> a
sum''' = foldl1 (+)

--   - however, they cause runtime errors if they're called with empty lists,
--     where as the vanilla versions don't.

maxinmum' :: (Ord a) => [a] -> a
maximum' = foldr1 (\x acc -> if x > acc then x else acc)

reverse' :: [a] -> [a]
reverse' = foldl (\acc x -> x : acc) []

product' :: (Num a) => [a] -> a
product' = foldr1 (*)

filter' :: (a -> Bool) -> [a] -> [a]
filter' p = foldr (\x acc -> if p x then x : acc else acc) []

head' :: [a] -> a
head' = foldr1 (\x _ -> x)

last' :: [a] -> a
last' = foldl1 (\x _ -> x)

reverse'' :: [a] -> [a]
reverse'' = foldl (flip (:)) []

--   - scanl and scanr are like foldl and foldr, but they report all their
--     intermediate accumulator states by means of a list
--   - there's also scanl1 and scanr1

sqrtSums :: Int
sqrtSums = length (takeWhile (<1000) (scanl1 (+) (map sqrt [1..]))) + 1

--   - using takeWhile of course, because this is an infinite list
--
-- Function applications with $:
--   - function application via space is left-associative and highest precendence
--   - with $ it's right-associative and lowest precendece
--   - used most of the time for convenience so you can take it easy on the
--     parentheses.
--   - $ is kind of like putting one paren in its place, and then the other as far right
--     as it can go on the end of the expression
--   - apart from that, $ can be used to map function application over a list of functions
--     (i.e. giving $ 3 would apply all those functions onto 3)
--
-- Function Composition:
--   - same as in maths
--   - functions executed on argument left to right
--   - allows us to get rid of some lambdas in places they aren't needed
--   - another common use is declaring functions in the free point style,
--     where the last argument can be ommitted
--   - if there are parentheses in play, this cannot be done, so . can be
--     used to achieve this

{- fn x = ceiling (negate (tan (cos (max 50 x)))) -}

{- fn' x = ceiling . negate . tan . cos . max 50 -}

--   - a lot of the time such a stlye is more readable and concise.

oddSquareSum :: Integer
oddSquareSum = sum (takeWhile (<10000) (filter odd (map (^2) [1..])))

oddSquareSum' :: Integer
oddSquareSum' = sum . takeWhile (<10000) . filter odd . map (^2) $ 1

--   - of course, though, readability counts...

oddSquareSum'' :: Integer
oddSquareSum'' =
    let oddSquares = filter odd $ map (^2) [1..]
        belowLimit = takeWhile (<10000) oddSquares
    in  sum belowLimit
