{-# LANGUAGE OverloadedStrings, ExtendedDefaultRules #-}

module DBOperation where


import           Data.ByteString (ByteString)
import           Database.MongoDB
import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import qualified Snap.Snaplet.MongoDB as DB

import Application
import Models

dbname = "products"
withDB = DB.withDB

-- FIXME: type??
fetchList tname fn = do
    results <- ( withDB $ find (select [] tname) >>= rest )
    return $ datas results fn
  where
    datas (Left _) _   = []
    datas (Right r) fn = map fn r

-- | FIXME: `show` will enclose " which is bad to UI
fetchValue s r = show $ valueAt s r

-- | Get All Tags
getAllTags :: AppHandler [Tag]
getAllTags        = fetchList "tags" convertTag
convertTag result = Tag { oid = fetchValue "_id" result,
                          name = fetchValue "name" result}

-- | Get All Products
getProducts :: AppHandler [Product]
getProducts     = fetchList "products" convertP
convertP result = Product { pid = fetchValue "pid" result,
                            pname = fetchValue "pname" result}

-- | FIXME: pull DB
products :: IO [Product]
products = return $ zipWith Product ["1","2","3"] ["Gorriot","Ray","Simon"]

findProduct :: ByteString -> IO Product
findProduct input = fmap findP products
  where
    input' = bs2String input
    eqPid = (== input') . pid
    findP = (head . filter eqPid)   -- ^ FIXME: head will agianst empty list when pid doesn't exists.

-- | FIXME: saveOrder
saveOrder :: ByteString -> IO UserOrder
-- saveOrder "" = ...  --^ pid could be ""
saveOrder pid = do
  return  UserOrder { orderId = "dumy-order-id", orderPid = bs2String pid}

-- | ByteString to String
--   exists functions? or really necessary
-- ?? import qualified Data.ByteString.Char8 as U
--    :t U.unpack ??
bs2String :: ByteString -> String
bs2String = T.unpack . T.decodeUtf8
