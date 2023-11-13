import Data.List (find)

swapLetter :: Char -> Char
swapLetter c
  | c == 'G' = 'C'
  | c == 'C' = 'G'
  | c == 'T' = 'A'
  | c == 'A' = 'U'

toRNA :: String -> Either Char String
toRNA xs =
  let ch = find (`notElem` "GCTA") xs
   in case ch of
        Just c -> Left c
        Nothing -> Right (map swapLetter xs)
