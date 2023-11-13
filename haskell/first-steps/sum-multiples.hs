-- Your task is to write the code that calculates the energy points that get awarded to players when they complete a level.
-- The energy points are awarded according to the following rules:
-- For each magical item, take the base value and find all the multiples of that value that are less than the level number.
--  Combine the sets of numbers.
--  Remove any duplicates.
--  Calculate the sum of all the numbers that are left.

import Data.List (nub)
import Data.List qualified as L

minMul :: Integer -> Integer -> Integer
minMul num limit
  | num == 0 = 0
  | limit `mod` num == 0 = (limit `div` num) - 1
  | otherwise = limit `div` num

sumOfMultiples :: [Integer] -> Integer -> Integer
sumOfMultiples factors limit = sum $ L.nub [x * y | x <- factors, y <- [1 .. (minMul x limit)]]