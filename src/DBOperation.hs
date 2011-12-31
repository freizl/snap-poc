{-# LANGUAGE OverloadedStrings, ExtendedDefaultRules #-}

module DBOperation where

import           Data.ByteString (ByteString)
import qualified Data.Text as T
import qualified Data.Text.Encoding as T

import Database.MongoDB

import Models

dbname = "blog"

-- | FIXME: a general list search
--        searchList :: Pipe -> String -> ? -> IO [a]

getAllTags :: Pipe -> IO [Tag]
getAllTags pipe = do
    let run = access pipe master dbname
    tags <- ( run $ find (select [] "tags") >>= rest )
    return $ datas tags
    where 
        datas (Left _) = []
        datas (Right results) = map convert results
        convert result = Tag { oid = show $ valueAt "_id" result, name = show $ valueAt "name" result}
        
-- | FIXME: pull DB
products :: IO [Product]
products = return $ zipWith Product ["1","2","3"] ["Gorriot","Ray","Simon"]

-- | FIXME: pull DB
findProduct :: ByteString -> IO Product
findProduct input = fmap findP products
  where
    input' = bs2String input
    eqPid = (== input') . pid
    findP = (head . filter eqPid)   -- ^ FIXME: head will agianst empty list when pid doesn't exists.

-- | FIXME: saveOrder
orders :: Pipe -> IO [UserOrder]
orders pipe = do
    let run = access pipe master dbname
    tags <- ( run $ find (select [] "orders") >>= rest )
    return $ datas tags
    where 
        datas (Left _) = []
        datas (Right results) = map convert results
        convert result = UserOrder { orderId = show $ valueAt "orderId" result, orderPid = show $ valueAt "pid" result}

-- | ByteString to String
--   exists functions? or really necessary
-- ?? import qualified Data.ByteString.Char8 as U
--    :t U.unpack ??
bs2String :: ByteString -> String
bs2String = T.unpack . T.decodeUtf8
