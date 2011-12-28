module Main where

main = print $ DP "simon" "wu"

data TP = DP 
    { firstName :: String
    , lastName  :: String
    } deriving(Eq,Show)
