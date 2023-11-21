data Clock = Clock {hours :: Int, minutes :: Int}
  deriving (Eq, Show)

showNum :: Int -> String
showNum n = if n < 10 then "0" ++ show n else show n

fromHourMin :: Int -> Int -> Clock
fromHourMin hours minutes =
  let (h, m) = calculateTime (hours, minutes)
   in Clock {hours = h, minutes = m}

toString :: Clock -> String
toString (Clock hours minutes) = showNum hours ++ ":" ++ showNum minutes

calculateTime :: (Int, Int) -> (Int, Int)
calculateTime (hours, minutes) = calc ((hours * 60) + minutes)
  where
    calc t = ((t `div` 60) `mod` 24, t `mod` 60)

addDelta :: Int -> Int -> Clock -> Clock
addDelta nHours nMinutes (Clock hours minutes) =
  let (newHours, newMinutes) = calculateTime (hours + nHours, minutes + nMinutes)
   in fromHourMin newHours newMinutes
