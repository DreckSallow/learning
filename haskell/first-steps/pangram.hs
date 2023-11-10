import Data.Char (toLower)
import Data.Set as Set

isPangram :: String -> Bool
isPangram text
  | length text < 26 = False
  | otherwise =
      let alphabet = Set.fromList ['a' .. 'z']
       in Set.null $ Set.difference alphabet (Set.fromList (Prelude.map toLower text))
