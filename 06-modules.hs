-- Modules:
--   - a haskell module is a colleciton of related functions, types and
--     typeclasses.
--   - a haskell program is a collection of modules where the main modules
--     loads up the other modules and then usees the functions defined
--     in them to do something.
--   - seperating up code means you may be able to reuse it later on
--   - the syntax for importin is import <module_name>
--   - this must be done before defining any functions, so they are usually
--     placed at the top of the file.

import Data.List

numUniques :: (Eq a) => [a] -> Int
numUniques = length . nub

--   - loading in GHCi can be done with:
--      :m + Data.List
--   - if you want to load several:
--      :m + Data.List Data.Map Data.Set
--   - if you only need a couple functions from a module:
--      import Data.List (nub, sort)
--   - if you want everything except something specific:
--      import Data.List hiding (nub)
--   - to make sure namespaces don't conflict:
--      import qualified Data.Map
--   - to assign a name to a qualified import:
--      import qualified Data.Map as M
--   - use Hoogle to search for functions

-- Data.List:
--   - intersperse takes an element and a list and then puts that element
--     between each pair of elements in the list
--   - intercalate takes a list of lists and a list, then insterts that
--     list in between all those lists and then flattens the result
--   - transpose transpooses a list of lists; if the list is regarded as a
--     2D matrix, the columns become the rows and vice versa
--   - foldl' and foldl1' are stricter versions of their lazy siblings,
--     stopping stack overflow errors from using lazy folds on really
--     big lists
--   - concat flattens a list of lists into just a list
--   - concatMap is the same as first mapping a function to a list then
--     concatenating the resulting list
--   - and takes a list of boolean values and returns True if all the values
--     in the list are True
--   - or returns True if one or more values in the list of True
--   - any and all take a predicate and then check if any or all elements
--     in the list satisfy the predicate, respectively
--   - iterate takes a function and a starting valyem applying the function to
--     the starting value, then to that result, and the result of that, and
--     so on
--   - splitAt takes a number and a list, and then splits the list at that
--     many elements, returning the resulting two lists in a tuple
--   - takeWhile takes elements from a list while the predicate is met
--   - dropWhile is similar, in only drops elements while the predicate is
--     True
--   - span is like takeWhile, only it returns a pair of lists
--   - break does the same but splits the list when the predicate is
--     satisfied
--   - sort sorts a list
--   - group takes a list and groups adjacent elements into sublists if they
--     are equal
--   - inits and tails are like init and tail, only they recursively apply
--     to that list until there's nothing left
--   - isInfixOf looks for a sublist in a list
--   - isPrefixof and isSuffixOf search for sublists at the beginning and
--     end of a list respectively
--   - elem and notElem check if an element is or isn't inside a list
--   - partition takes a list and a predicate and seperates the elements
--     that do and don't satisfy the predicate into two lists
--   - find takes a list and a predicate and returns the first element that
--     satisfies the predicate
--   - elemIndex is like elem but returns the index or Nothing
--   - elemIndices is like elemIndex, only it returns a list of indices
--     or an empty list
--   - findIndex is like find but retuns the index of the first element that
--     satisfies the predicate, findIndices does the same but returns a list
--   - zip and zipWith can appear in a zipx form where 3 <= x <= 8
--   - lines seperates strings into a list split by '\n'
--   - unlines does the reverse of lines
--   - words splits text by spaces, unwords does the opposite
--   - nub takes a list and removes duplicate elements
--   - delete takes an element and a list and deletes the first occurence of
--     that element in the list
--   - \\ is the list difference function
--   - union returns the union of two lists
--   - intersect retuns the intersection
--   - insert takes an elent and a list of elements that can be sorted and puts
--     in the last position where it's still less or equal to the next element
--   - there are a bunch of generic functions that use Num as their type instead
--     of Int
--   - nubBy, deleteBy, unionBy, intersectBy and groupBy take an equality
--     function and use that to compare
--   - on from Data.Function can define By-like functions
--   - there is also sortBy, insertBy, maximumBy and minimumBy
--   - lists can be compared bu they are compared lexographically

-- Data.Char
--   - functions that deal with characters
--   - iscontrol
--   - isSpace
--   - isLower
--   - isUpper
--   - isAlpha
--   - isAlphaNum
--   - isPrint
--   - isDigit
--   - isOctDigit
--   - isHexDigit
--   - isLetter
--   - isMark - unicode mark characters
--   - isNumber
--   - isPunctuation
--   - isSymbol
--   - isSeperator
--   - isAscii
--   - isLatin1
--   - isAsciiUpper
--   - isAsciiLower
--   - using Data.List all, 
