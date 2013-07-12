-- Pattern Matching:
--   - Consists of specifying patterns to which data could conform
--     and then checking to see if it does and acting appropriately
--   - Different functions defined for different patterns.
--   - You can pattern match on any data type.

lucky :: (Integral a) => a -> String
lucky 7 = "LUCKY NUMBER SEVEN!"
lucky x = "Sorry, you're out of luck, pal!"

--   - Patterns are checked from top to bottom, and when it conforms
--     to a pattern the corresponding function body is used.

sayMe :: (Integral a) => a -> String
sayMe 1 = "One!"
sayMe 2 = "Two!"
sayMe 3 = "Three!"
sayMe 4 = "Four!"
sayMe 5 = "Five!"
sayMe x = "Not between 1 and 5"

--   - Moving the last pattern to the top would result in the same output
--     every time, as it is 'catch-all' 
--   - Using pattern matching we can also define recursive functions with
--     base and other cases:

factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial (n - 1)

--   - Recursion is important in Haskell.
--   - Pattern matching can fail:

charName :: Char -> String
charName 'a' = "Albert"
charName 'b' = "Broseph"
charName 'c' = "Cecil"

--     When called with unexpected input, i.e. 'h', an exception will be
--     raised. Always include a catch-all pattern.
--   - Several funcitons can be rewritten in a pattern-matching style:

addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors (a b = (fast a + fsat b, snd a + snd b)

--     Here's it in pattern-matching style:

addVectors' :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors' (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

--   - The above is already a catch-all pattern, and the type guarantess
--     two pairs as parameters.
--   - fst and second act on pairs, but what about triples?

first :: (a, b, c) -> a
first (x, _, _) = x

second :: (a, b, c) -> b
second (_, y, _) = y

third :: (a, b, c) -> c
third (_, _, z) = z

--   - _ means the same as it does in list comps: we don't care.
--   - You can pattern match in list comprehensions too, for example:
--     [a+b | (a,b) <- xs]
--   - Pattern matching against lists can match the empty list or anything
--     with : and the empty list.
--   - With x:xs, x will bind the head of the list and xs will be the rest.
--   - If you want to get the first three you'd do x:y:z:zs.
--   - It'll only match against lists of three or more.

head' :: [a] -> a
head' :: [] = error "Can't call head on an empty list."
head' (x:_) = x

--  - When binding more than one variable you must surround them in parens,
--    even with x:xs.
--  - The error function... well, raises errors.

tell :: (Show a) => [a] -> String
tell [] = "the list is empty"
tell (x:[]) = "The list has one element: " ++ show x
tell (x:y:[]) = "The list has two elements: " ++ show x ++ " and " ++ show y
tell (x:y:_) = "This list is long. The first two elements are: " ++ show x ++ " and " ++ show y

--  - This function is safe because it deals with every possible case.
--  - (x:[]) could be rewritten as [x], (due to syntactic sugar) but not
--    (x:y:_) because it matches any list of length 2 or more.

length' :: (Num b) => [a] -> b
length' [] = 0
length' (_:xs) = 1 + length' xs

sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x sum' xs

--  - as patters allow you to keep a reference to a pattern

capital :: String -> String
capital "" = "Empty string."
capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]

--    this way you don't have to repeat patterns in the funciton body

-- [ To continue with guards ]
