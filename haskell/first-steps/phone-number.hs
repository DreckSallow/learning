import Data.Char (isNumber, isSpace)
import Data.Char qualified as Char
import Data.List (dropWhile, dropWhileEnd)
import Data.List qualified as List
import Data.Maybe (isJust)
import Data.Maybe qualified as Maybe

splitStrBy :: [Char] -> [Char] -> [[Char]] -> [[Char]]
splitStrBy str chars acc
  | null chars = [str]
  | null str = acc
  | otherwise =
      let (firstAcc, lastAcc) =
            if null acc
              then ([], [])
              else (init acc, last acc)
       in if head str `elem` chars
            then splitStrBy (drop 1 str) chars (acc ++ [[]])
            else splitStrBy (drop 1 str) chars (firstAcc ++ [lastAcc ++ [head str]])

trim :: String -> String
trim = List.dropWhileEnd Char.isSpace . List.dropWhile Char.isSpace

splitPhone :: String -> [String]
splitPhone str = List.filter (not . null) $ map trim (splitStrBy str " -." [])

checkSufix :: String -> Bool
checkSufix str = str == "+1" || str == "1"

checkFirst :: String -> Maybe String
checkFirst str
  | length str == 3 = checkSecond str
  | length str == 5 = checkSecond ((init . tail) str)
  | otherwise = Nothing

checkSecond :: String -> Maybe String
checkSecond str
  | length str /= 3 = Nothing
  | otherwise =
      if head str `elem` "23456789" && all (`elem` "0123456789") (tail str)
        then Just str
        else Nothing

checkThird :: String -> Maybe String
checkThird str
  | length str /= 4 = Nothing
  | otherwise =
      if all (`elem` "0123456789") str
        then Just str
        else Nothing

filterMaybes :: [Maybe a] -> [a]
filterMaybes [] = []
filterMaybes list = case head list of
  Nothing -> filterMaybes (tail list)
  Just el -> el : filterMaybes (tail list)

checkPhone :: [String] -> Maybe String
checkPhone parts
  | length parts /= 3 = Nothing
  | otherwise =
      let checkeds = [checkFirst (head parts), checkSecond (parts !! 1), checkThird (parts !! 2)]
          filtereds = filterMaybes checkeds
       in if length filtereds /= 3
            then Nothing
            else Just (concat filtereds)

number :: String -> Maybe String
number str =
  let split = splitPhone str
   in case length split of
        1 -> if length (head split) == 11 && head (head split) == '1' then Just $ tail (head split) else Nothing
        3 -> checkPhone split
        4 -> if checkSufix (head split) then checkPhone (tail split) else Nothing
        _ -> Nothing
