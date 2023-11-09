main = do
  print (isLeapYear 2022)

isLeapYear :: Integer -> Bool
isLeapYear year
  | year `mod` 4 /= 0 = False
  | year `mod` 4 == 0 && year `mod` 100 /= 0 = True
  | year `mod` 400 == 0 && year `mod` 100 == 0 = True
  | otherwise = False

{-

OTHER SOLUTION

isLeapYear :: Integer -> Bool
isLeapYear year
  | year `mod` 4 /= 0 = False
  | year `mod` 100 /= 0 = True
  | year `mod` 400 /= 0 = False
  | otherwise = True

-}