import Data.Char (isAlpha, isLower, isUpper)
import Data.Char qualified as Char
import Data.List (drop)
import Data.List qualified as List
import Data.Text (Text, map, pack, toUpper, unpack)
import Data.Text qualified as Text

divisors :: [Char]
divisors = " _-"

rawFilterChars :: ((Maybe Char, Char, Int) -> Bool) -> [Char] -> [Char] -> Int -> [Char]
rawFilterChars f chars acc index
  | null chars = acc
  | length chars == 1 = acc
  | otherwise =
      let (first, current) =
            if index == 0
              then (Nothing, head chars)
              else (Just (head chars), chars !! 1)
       in if f (first, current, index)
            then rawFilterChars f (List.drop 1 chars) (acc ++ [current]) (index + 1)
            else rawFilterChars f (List.drop 1 chars) acc (index + 1)

filterChars :: ((Maybe Char, Char, Int) -> Bool) -> [Char] -> [Char]
filterChars f chars = rawFilterChars f chars [] 0

upperFilter :: (Maybe Char, Char, Int) -> Bool
upperFilter (Nothing, current, _) = Char.isAlpha current -- First letter case
upperFilter (Just prev, current, _) = Char.isUpper current && (Char.isLower prev || prev `elem` divisors)

lowerFilter :: (Maybe Char, Char, Int) -> Bool
lowerFilter (Nothing, current, _) = Char.isAlpha current -- First letter case
lowerFilter (Just prev, current, _) = Char.isAlpha current && prev `elem` divisors

abbr :: Text -> Text
abbr xs
  | Text.null xs = Text.pack ""
  | Text.length xs == 0 = Text.toUpper xs
  | otherwise = Text.toUpper $ Text.pack (filterChars (\c -> upperFilter c || lowerFilter c) (Text.unpack xs))