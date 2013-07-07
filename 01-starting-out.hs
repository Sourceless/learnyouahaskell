-- math operators (+ - / *) work as you think (infix)
-- parens denote order of operation (as usual)
-- boolean operators are && (and), || (or), and not
-- equality is tested with ==, inequality with /= (not-equal-to)
-- strict typing

-- functions introduced in this part:
--   - succ (takes anything that has a defined successor and returns that)
--   - min & max

doubleMe x = x + x

-- doubleUs x y = x*2 + y*2
doubleUs x y = doubleMe x + doubleMe y

doubleSmallNumber x = if x > 100
		        then x
			else x*2

doubleSmallNumber' x = (if x > 100 then x else x*2) + 1


-- function identifiers:
--   - must start with a lowercase letter
--   - can include apostrophes in their names
--   - are known as 'defintions' if they take no parameters
conanO'Brien = "It's a-me, Conan O'Brien!"

-- Lists:
--   - syntax: [1,2,3,..]
--   - are homogenous (every item is of the same type)
--   - strings are lists of characters (denoted by single quotes)

--   - Operators:
--       - ++, concatenation. Has to walk through entire list on left side.
--	 - :, cons. Instantaneous (apparently).

--   - [1,2,3] is acutally syntactic sugar for 1:2:3:[] where [] is an empty list
--   - lists can be nested

--   - indexing is performed with the !! operator, e.g. "Chuck Norris" !! 6 == 'B'
--   - indeces start at zero

--   - Comparison:
--	  - lists compared in order - first item first, thene the second if those are equal and so on
--	  - regular comparison operators (<, <=, ==, >=, >)

--   - Functions that act on lists:
--        - head takes the first element of a list
--        - tail returns all elements except the 'head'
--        - last returns the last element of the list
--        - init returns everything but the last element of the list
--	  - when using any of the above on an empty list, an exception will be thrown

--	  - length returns the length of a given list
--	  - null tells you if a list is empty
--	  - reverse does what it says
--	  - take <x> <list> takes x elements from list and returns them
--	  - drop is simlar, dropping elements from the start of a list and returning what's left
--	  - maximum returns the biggest element
--	  - minimum, the smallest
--	  - sum returns the sum of the numbers in a list
--	  - product returns the product of a lsit of numbers
--	  - elem tells you if an element is in a list

-- Infix:
--   - You can use any function in infix notation by using backticks: `function`
--   - (?) probably need an arity of 2 for this

-- Ranges:
--   - [1..20] gives a list from 1 to 20 inclusive
--   - ['a'..'z'] - "abc...xyz"
--   - you can define steps: [2,4..20] == [2,4,6,8,...20]
--   - only one step can be specified
--   - wierd things can happen if you try to use it with floating-point numbers

-- Infinite Lists:
--   - cycle takes a list and 'cycles' it into and infinite list
--   - repeat produces an infinite list of a single element
--   - replicate can mirror repeat's behaviour if you only want a certain number

-- List comprehensions:
--   - general form: [ output function | input list, predicate(s) ]
--   - [x*2 | x <- [1..10]] returns a list of all the number from 1 to 10 doubled
--   - [x*2 | x <- [1..10], x*2 >= 12] will do the same, but only for the numbers more than or equal to 12 when doubled

boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]

--   - also, you can use more than one input list
--   : [x*y | x <- [2,5,10], y <- [8,10,11]]

length' xs = sum [1 | _ <- xs]

--   - _ denotes that whatever's pulled out the list doesn't matter

removeNonUppercase st = [c | c <- st, c `elem` ['A'..'Z']]

--   - nested lists work too
--   : [ [ x | x <- xs, even x ] | xs <- xxs]

-- Tuples:
--   - heterogenous, you can have thing of different types in them
--   - fixed length, you can't do [(1), (1,2), (1)]
--   - tuples of different lengths are *different types*

-- Functions that make use of tuples:
--   - fst: takes a pair (2-tuple) and returns the first element
--   - snd: takes a pair and returns the second element

--   - zip: takes two lists and makes them one list of 2-tuples
--   : zip [1,2,3] ["one", "two", "three"]

-- A common pattern in Haskell is taking a starting set of solutions and them applying transformations and filters to get a final answer.
