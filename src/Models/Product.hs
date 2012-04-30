{-# LANGUAGE OverloadedStrings, ExtendedDefaultRules #-}

module Models.Product where

import qualified Data.ByteString as BS

import Application
import Models.Common

data Product = Product
    { pid   :: BS.ByteString     -- ^ oid
    , pname :: BS.ByteString     -- ^ Product name
    } deriving (Show)

-- | Get All Products
getProducts :: AppHandler [Product]
getProducts = fetchList "products" convertP'

convertP' result = Product { pid = fetchValue "pid" result,
                            pname = fetchValue "pname" result}

-- | Mock Products
mockProducts :: IO [Product]
mockProducts = return $ zipWith Product ["1","2","3"] ["Gorriot","Ray","Simon"]

mockFindProduct :: BS.ByteString -> IO Product
mockFindProduct input = fmap findP mockProducts
  where
    eqPid = (== input) . pid
    findP = (head . filter eqPid)   -- ^ FIXME: head will agianst empty list when pid doesn't exists.

