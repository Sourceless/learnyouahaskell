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
--   - by calling functions with too few parameters you're 
