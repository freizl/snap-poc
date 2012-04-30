{-# LANGUAGE OverloadedStrings, ExtendedDefaultRules #-}

module Models.Product
    ( Product (..)
    , getProducts
    , mockProducts
    , mockFindProduct) where

import qualified Data.ByteString as BS

import Application
import Models.Common

data Product = Product
    { productId   :: BS.ByteString     -- ^ oid
    , productName :: BS.ByteString     -- ^ Product name
    } deriving (Show)

-- | Get All Products
getProducts :: AppHandler [Product]
getProducts = fetchList "products" convertP'

convertP' result = Product { productId = fetchValue "pid" result,
                            productName = fetchValue "pname" result}

-- | Mock Products
mockProducts :: IO [Product]
mockProducts = return $ zipWith Product ["1","2","3"] ["Gorriot","Ray","Simon"]

mockFindProduct :: BS.ByteString -> IO Product
mockFindProduct input = fmap findP mockProducts
  where
    eqPid = (== input) . productId
    findP = (head . filter eqPid)   -- ^ FIXME: head will agianst empty list when pid doesn't exists.

