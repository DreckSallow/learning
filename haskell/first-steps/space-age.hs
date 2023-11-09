data Planet
  = Mercury
  | Venus
  | Earth
  | Mars
  | Jupiter
  | Saturn
  | Uranus
  | Neptune

-- deriving (Eq)

-- planetToNum :: Planet -> Float
-- planetToNum planet
--   | planet == Mercury = 0.2408467
--   | planet == Venus = 0.61519726
--   | planet == Earth = 1.0
--   | planet == Mars = 1.8808158
--   | planet == Jupiter = 11.862615
--   | planet == Saturn = 29.447498
--   | planet == Uranus = 84.016846
--   | planet == Neptune = 164.79132

planetToNum :: Planet -> Float
planetToNum planet =
  case planet of
    Mercury -> 0.2408467
    Venus -> 0.61519726
    Earth -> 1.0
    Mars -> 1.8808158
    Jupiter -> 11.862615
    Saturn -> 29.447498
    Uranus -> 84.016846
    Neptune -> 164.79132

ageOn :: Planet -> Float -> Float
ageOn planet seconds = seconds / (31557600 * planetToNum planet)