import Data.Char (isAlpha, isSpace, isUpper)
import Data.Text (Text, null, strip)
import Data.Text qualified as T

checkAllUpper :: Text -> Bool
checkAllUpper text =
  let filtered = T.filter isAlpha text
   in not (T.null filtered) && T.all isUpper filtered

responseFor :: Text -> Text
responseFor str
  | T.null text || T.all isSpace text = T.pack "Fine. Be that way!"
  | checkAllUpper text && T.last text == '?' = T.pack "Calm down, I know what I'm doing!"
  | checkAllUpper text = T.pack "Whoa, chill out!"
  | T.last text == '?' = T.pack "Sure."
  | otherwise = T.pack "Whatever."
  where
    text = T.strip str

main =
  print (responseFor (T.pack "WATCH OUT!"))