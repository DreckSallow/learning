import Data.Map (Map, fromList, insert, lookup)
import Data.Map qualified as Map
import Data.Maybe (isNothing)

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show)

strToNucleotide :: Char -> Maybe Nucleotide
strToNucleotide ch
  | ch == 'A' = Just A
  | ch == 'C' = Just C
  | ch == 'G' = Just G
  | ch == 'T' = Just T
  | otherwise = Nothing

shiftStr :: [Char] -> (Maybe Char, [Char])
shiftStr [] = (Nothing, [])
shiftStr (f : o) = (Just f, o)

nucleotidesMap :: Map Nucleotide Int
nucleotidesMap = Map.fromList [(A, 0), (C, 0), (G, 0), (T, 0)]

checkChain :: [Char] -> Map Nucleotide Int -> Maybe (Map Nucleotide Int)
checkChain str map =
  if null str
    then Just map
    else
      let (first, part) = shiftStr str
          parsedNucl = strToNucleotide =<< first
          count = case parsedNucl of
            Nothing -> Nothing
            Just p -> Map.lookup p map
       in case (count, parsedNucl) of
            (Just c, Just k) -> checkChain part (Map.insert k (c + 1) map)
            _ -> Nothing

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts xs =
  case checkChain xs nucleotidesMap of
    Nothing -> Left "INVALID"
    Just c -> Right c