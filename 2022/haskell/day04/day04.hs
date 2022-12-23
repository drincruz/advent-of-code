import Data.List.Split

strParts :: String -> [String]
strParts str = splitOn "," str

getLines :: String -> [String]
getLines str = do
  splitOn "\n" str

tuplePair :: [b] -> (b, b)
tuplePair [x, y] = (x, y)

getRangeTuples :: [Char] -> [[Char]]
getRangeTuples str = do
  splitOn "-" str

listStrToInt :: [String] -> [Int]
listStrToInt = map read

mapSubListRanges :: [[Char]] -> [(Int, Int)]
mapSubListRanges sublist = do
  let updated = map getRangeTuples sublist
  map tuplePair $ map listStrToInt updated

mapListParts :: [[[Char]]] -> [[(Int, Int)]]
mapListParts l = do
  map mapSubListRanges l

assignmentPairFullyContains :: (Ord a1, Ord a2) => [(a1, a2)] -> Bool
assignmentPairFullyContains [(l, r), (x, y)] = do
  (l <= x && r >= y) || (x <= l && y >= r)

main :: IO ()
main = do
  contents <- readFile "data.txt"
  print
    $ length
    $ filter(assignmentPairFullyContains)
    $ mapListParts
    $ map strParts
    $ getLines contents

