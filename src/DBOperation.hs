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
--          return IO Maybe Product
findProduct :: ByteString -> IO Product
findProduct input = fmap findP products
  where
    input' = bs2String input
    eqPid = (== input') . pid
    findP = (head . filter eqPid)

-- saveOrder

orders :: Pipe -> IO [Order]
orders pipe = do
    let run = access pipe master dbname
    tags <- ( run $ find (select [] "orders") >>= rest )
    return $ datas tags
    where 
        datas (Left _) = []
        datas (Right results) = map convert results
        convert result = Order { orderId = show $ valueAt "orderId" result, pid = show $ valueAt "pid" result}

-- | ByteString to String
--   exists functions?? or really necessary
bs2String :: ByteString -> String
bs2String = T.unpack . T.decodeUtf8
