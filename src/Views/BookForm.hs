{-# LANGUAGE OverloadedStrings, TemplateHaskell #-}
module Views.BookForm where

import Control.Applicative ((<$>), (<*>))

import Data.Text (Text)
import Text.Digestive

data Lang = EN | CN
    deriving (Eq, Show)
             
data Book = Book
    { bookName :: Text
    , description :: Text
    , language :: Lang
    } deriving (Show)

bookForm :: Monad m => Form Text m Book
bookForm = Book
    <$> "name" .: text (Just "Real World Haskell")
    <*> "description" .: text Nothing
    <*> "language" .: choice [(EN, "English"), (CN, "Chinese")] Nothing
