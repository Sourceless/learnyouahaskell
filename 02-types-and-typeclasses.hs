-- static type system (types know at compile time)
-- due to this, less potential runtime errors
-- types can be inferred:
--   - If you write a number, the language knows it's a number

-- every expression has a type
-- the :t command in GHCI will tell you the type of an expression
-- :: means 'is of type'

-- functions can be given explicit type declarations
-- it's considered good practice unless the function is very short

removeNonUppercase :: [Char] -> [Char]
removeNonUppercase st = [c | c <- st, c `elem` ['A'..'Z']]

-- [Char] -> [Char]
-- means that the function takes a list of characters and returns a list of characters

-- What if the function takes more than one parameter?
-- Do this:
addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z

-- Some common types:
--   - Int: integer (bounded)
--   - Integer: integer (unbounded, but less efficient)

-- This is a good function for integer because the numbers can get huge
factorial :: Integer -> Integer
factorial n = product [1..n]

--   - Float: single precision floating point number
circumference :: Float -> Float
cirumference r = 2 * pi * r

--   - Double: double precision floating point number
circumference' :: Double -> Double
circumference' r = 2 * pi * r

--   - Bool: boolean ('True' or 'False')
--   - Char: a single character ([Char] is a string, i.e. a list of characters)

-- Type Variables:
--   - not in capital case
--   - means it can be of any type
--   - different letters for mulitple type vars that may or may not be the same type

-- Typeclasses:
--   - (aside) operators are functions too
--   - everything before => is a class constraint
--   - the == function, for example takes any two values of the same type
--     and returns a Boolean
--   - The Eq typeclass provides an interface for testing equality. All standard
--     Haskell types excpet IO are part of this typeclass
--   - Basic Typleclasses:
--       - Eq: used for types that support equality testing. The functions its
--	   members implement are == and /=
--       - Ord: for types that have an ordering. This covers all the standard
--         comparison functions such as >, < >= and <=. The 'compare' function
--         takes two Ord members of the same type and returns an ordering.
--       - Ordering: a type that can be GT, LT, or EQ (greater, less than, equal).
--       - To be a member of Ord, a type must first be a member of Eq.
--       - Show: members can be presented as strings. The funciton 'show' deals with
--               Show. It takes a value of a member of Show and presents it as a string
--       - Read: Show's completment. 'read' takes a string and returns a type which is
--               a member of Read. (also see 'Explicit Type Annotations')
--       - Enum: sequentially ordered types - i.e. they can be enumerated. Also have
--               defined successors and predecessors which can be gotten using
--               'succ' and 'pred'.
--       - Bounded: members have an upper and lower bound.
--       - Num: a numeric typeclass. Its members are able to act like numbers -
--              Int, Integer, Float, and Double are all in Num. To be in Num,
--              a type must also be in Eq and Show
--       - Integral: also numeric, but only allows whole numbers.
--       - Floating: floating-point numbers only.

-- 'fromIntegral' takes an Integral number and turns it into the more general Num.
-- Class  constraints are allowed inside type declarations


-- Explicit Type Annotations:
--   - A way of explicitly saying what type an expression should be. :: followed by type.
--   - Usually the compiler can infer the type, but sometimes ambiguity must be removed,
--     for example when 'read' is used.

