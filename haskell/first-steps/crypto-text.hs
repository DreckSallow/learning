module CryptoText where

import Data.Char (isAlphaNum, toLower)
import Data.List

-- STAR HELPERS
normalize :: String -> String
normalize = map toLower . filter isAlphaNum

divisors :: Int -> [Int]
divisors n = 1 : filter ((== 0) . rem n) [2 .. (n `div` 2)] <> [n]

fill :: Int -> a -> [a] -> [a]
fill len fill init = init <> replicate len fill

chunks :: Int -> String -> [String]
chunks _ [] = []
chunks len li =
  let (first, last) = splitAt len li
      lenLast = length last
   in first
        : if lenLast /= 0 && lenLast < len
          then chunks len (fill (len - lenLast) ' ' last)
          else chunks len last

-- END HELPERS

getSize :: Int -> (Int, Int)
getSize n =
  let dividers = divisors n
      middle = length dividers `div` 2
   in if even $ length dividers
        then
          let (rows, cols) = (dividers !! (middle - 1), dividers !! middle)
           in if cols - rows <= 1
                then (rows, cols)
                else getSize (n + 1)
        else (dividers !! middle, dividers !! middle)

joinWith :: a -> [a] -> [a]
joinWith _ [] = []
joinWith i (x : xs) = [x] ++ [i] ++ xs

encode :: String -> String
encode xs =
  let parsed = normalize xs
      (_, cols) = getSize (length parsed)
      strChunks = transpose (chunks cols parsed)
      (first, last) = splitAt (length strChunks - 1) strChunks
   in concatMap (++ " ") first <> concat last
