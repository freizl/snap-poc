{-# LANGUAGE OverloadedStrings, ExtendedDefaultRules #-}

module Models where

data Tag = Tag 
    { oid  :: String     -- ^ oid
    , name :: String     -- ^ Tag name
    } deriving (Show)
                      
data Config = Config 
    { title    :: String  -- ^ title
    , subTitle :: String  -- ^ sub title
    } deriving (Show)

data Product = Product
    { oid  :: String     -- ^ oid
    , name :: String     -- ^ Product name
    } deriving (Show)
                      
