module Darts (score) where

checkPoints :: Float -> Int
checkPoints n
  | n <= 1 = 10
  | n <= 5 = 5
  | n <= 10 = 1
  | otherwise = 0

score :: Float -> Float -> Int
score x y =
  let res = sqrt $ (x * x) + (y * y)
   in checkPoints (abs res)
