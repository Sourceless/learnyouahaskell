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
