-- Day 04 - Camp Cleanup
--  - Part01
--     * Find fully overlapping integer ranges

--  - Part02
--     * Find all partially overlapping integer ranges

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

assignmentPairOverlaps :: (Eq a, Enum a) => [(a, a)] -> Bool
assignmentPairOverlaps[(l, r), (x, y)] = do
  elem l [x..y] || elem r [x..y] || elem x [l..r] || elem y [l..r]

-- Wrapper to bind the data parsing and mapping
getListOfTuples :: String -> [[(Int, Int)]]
getListOfTuples contents = do
  mapListParts
  $ map strParts
  $ getLines contents

main :: IO ()
main = do
  contents <- readFile "data.txt"
  -- Part 01
  print
    $ length
    $ filter(assignmentPairFullyContains)
    $ getListOfTuples contents
--  Part02
  print
    $ length
    $ filter(assignmentPairOverlaps)
    $ getListOfTuples contents
