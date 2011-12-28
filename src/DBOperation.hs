{-# LANGUAGE OverloadedStrings, ExtendedDefaultRules #-}

module DBOperation where

import Database.MongoDB

import Models

dbname = "blog"

getAllTags :: Pipe -> IO [Tag]
getAllTags pipe = do
    let run = access pipe master dbname
    tags <- ( run $ find (select [] "tags") >>= rest )
    return $ datas tags
    where 
        datas (Left _) = []
        datas (Right results) = map convert results
        convert result = Tag { oid = show $ valueAt "_id" result, name = show $ valueAt "name" result}