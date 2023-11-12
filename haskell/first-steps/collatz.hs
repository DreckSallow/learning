rawCollatz :: Integer -> Integer -> Maybe Integer
rawCollatz n acc
  | n <= 0 = Nothing
  | n == 1 = Just acc
  | even n = rawCollatz (n `div` 2) (acc + 1)
  | otherwise = rawCollatz ((3 * n) + 1) (acc + 1)

collatz :: Integer -> Maybe Integer
collatz n = rawCollatz n 0

main =
  print (collatz 6)
