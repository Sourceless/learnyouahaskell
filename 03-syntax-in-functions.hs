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

-- Guards:
--   - patterns only work for structural purposes
--   - to test a property of a value, we use guards

bmiTell :: (RealFloat a) => a -> String
bmiTell bmi
    | bmi <= 18.5 = "You're underweight!"
    | bmi <= 25.0 = "You're normal."
    | bmi <= 30.0 = "You're fat!"
    | otherwise   = "You're a beached whale. Or perhaps a small moon."

--   - pipes indicate guards
--   - usually they're indented to the right and lined up
--   - basically a boolean expression
--   - otherwise is always True
--   - any expression can be used in the guard so long as it returns a Boolean:

bmiTell' :: (RealFloat a) => a -> a -> String
bmiTell' weight height
    | weight / height ^ 2 <= 18.5 = "You're underweight!"
    | weight / height ^ 2 <= 25.0 = "You're normal."
    | weight / height ^ 2 <= 30.0 = "You're fat!"
    | otherwise                   = "That's no moon..."

--   - notice that there's no = before the guards

max' :: (Ord a) => a -> a -> a
max' a b
    | a > b     = a
    | otherwise = b

--   - guards can also be written inline:

max'' :: (Ord a) => a -> a -> a
max'' a b | a > b = a | otherwise = b

--     but that doesn't necessarily help readability...

myCompare :: (Ord a) => a -> a -> Ordering
a `myCompare` b
    | a > b     = GT
    | a == b    = EQ
    | otherwise = LT

-- Where:
--   - where can be used to stop repetition in guard statements
--     and means we only have to calculate a common expression once

bmiTell'' :: (RealFloat a) => a -> a -> String
bmiTell'' weight height
    | bmi <= 18.5 = "You're underweight!"
    | bmi <= 25.0 = "You're normal."
    | bmi <= 30.0 = "You're fat!"
    | otherwise   = "Sorry, for a second there I thought you were your mother. You're too small."
    where bmi = weight / height ^ 2

--   - could go a bit further:

bmiTell''' :: (RealFloat a) => a -> a -> String
bmiTell''' weight height
    | bmi <= skinny = "You're underweight!"
    | bmi <= normal = "You're normal."
    | bmi <= fat    = "You're fat!"
    | otherwise     = "You lost weight negatively."
    where bmi = weight / height ^ 2
          skinny = 18.5
          normal = 25.0
          fat = 30.0

--   - for the bottom three lines, (skinny, normal, fat) = (18.5, 25.0, 30.0)
--     would also work.

initials :: String -> String -> String
initials firstname lastname = [f] ++ ". " ++ [l] ++ "."
    where (f:_) = firstname
          (l:_) = lastname

--   - it's not just constants that can be defined in where blocks, functions can too

calcBmis :: (RealFloat a) => [(a, a)] -> [a]
calcBmis xs = [bmi w h | (w, h) <- xs]
    where bmi weight height = weight / height ^ 2

--   - where bindings can be nested

-- Let:
--   - where bindings span a whole function
--   - let bindings have a more limited scope
--   - they can be used for pattern matching

cylinder :: (RealFloat a) => a -> a -> a
cylinder r h = 
    let sideArea = 2 * pi * r * h
        toparea = pi * r ^ 2
    in  sideArea + 2 * topArea

--   - the form is let <bindings> in <expression>
--   - things defined in the let part are only available in the in part
--   - let bindings are expressions, unlike where which is a syntactic construct
--   - they can be used to introduce functions into a local scope
--   - to bind several inline, use semicolons
--   - they can be nested
--   - you you can pattern match with let bindings
--   - they can go inside list comprehensions

clacBmis' :: (RealFloat a) => [(a, a)] -> [a]
calcBmis' xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2]

--   - in the same place as a predicate, but just binds names
--   - predicates and other sections can still be included

calcBmis'' :: (RealFloat a) => [(a, a)] -> [a]
calcBmis'' xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2, bmi >= 25.0]

--   - sometimes the in part of the let can be ommited when there is default behaviour
--     in place, like in listcomps or ghci

-- Case Expressions:
--   - somewhat similar to case statements in other languages
--   - are fully-fledged expressions
--   - allow evaluation based on values and pattern matching

head'' :: [a] -> a
head'' xs = case xs of [] -> error "No head for empty lists!"
                       (x:_) -> x

--   - don't have to write as much for the same effects seen earlier
--   - the expression, in the above case, is matched to the left side of the arrow,
--     the pattern. If it matches, that one is used.
--   - while pattern matching can only really be used for functions, case expressions
--     can be used more or less anywhere

describeList :: [a] -> String
describeList xs = "The list is " ++ case xs of [] -> "empty."
                                               [x] -> "a singleton list."
                                               xs -> "a longer list."

--   - also because pattern matching in function definitions is syntactic sugar for
--     case expressions, it could have been defined like this:

describeList' :: [a] -> String
describeList' :: xs = "The list is " ++ what xs
    where what [] = "empty."
          what [x] = "a singleton list."
          what xs = "a longer list."
