import Data.Map (Map, empty, insertWith)
import Data.Map qualified as Map
import Data.Text (Text, toLower, unpack)
import Data.Text qualified as Text

type MatchMap = Map Char Int

textToMap :: Text -> MatchMap
textToMap str = foldl (\acc char -> Map.insertWith (+) char 1 acc) Map.empty (Text.unpack str)

compareTexts :: Text -> MatchMap -> [Text] -> [Text]
compareTexts str strMatch others
  | null others = []
  | Text.toLower (head others) == str = []
  | otherwise =
      let first = head others
          missing = tail others
       in if textToMap (Text.toLower first) == strMatch then first : compareTexts str strMatch missing else compareTexts str strMatch missing

anagramsFor :: Text -> [Text] -> [Text]
anagramsFor xs = compareTexts (Text.toLower xs) (textToMap (Text.toLower xs))
