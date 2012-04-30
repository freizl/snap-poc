{-# LANGUAGE OverloadedStrings, ExtendedDefaultRules #-}

module Models.Tag 
    ( Tag (..)
    , getAllTags ) where

import Data.ByteString

import Application
import Models.Common

data Tag = Tag 
    { oid  :: ByteString     -- ^ oid
    , name :: ByteString     -- ^ Tag name
    } deriving (Show)
   
getAllTags :: AppHandler [Tag]
getAllTags        = fetchList "tags" convertTag


convertTag result = Tag { oid = fetchValue "_id" result,
                          name = fetchValue "name" result}
                                            
{-

data Config = Config 
    { title    :: String  -- ^ title
    , subTitle :: String  -- ^ sub title
    } deriving (Show)
                      
-}
