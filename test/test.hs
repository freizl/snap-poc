module Main where

-- FIXME: import ../src/Models.hs

main = print $ Product "simon" "wu"

data Product = Product
    { pid   :: Num     -- ^ oid
    , pname :: String     -- ^ Product name
    } deriving (Show)
                      
products :: [Product]
products = zipWith Product [1,2,3] ["Simon","Ray","John"]
