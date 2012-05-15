{-# LANGUAGE OverloadedStrings, TemplateHaskell #-}
module Views.BookForm where

import Control.Applicative ((<$>), (<*>))

import Data.Maybe
import Data.Text (Text)
import qualified Data.Text as T
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
    <$> "name" .: check "Book Name is Required." requiredBookName (text Nothing)
    <*> "description" .: text Nothing
    <*> "language" .: choice [(EN, "English"), (CN, "Chinese")] Nothing

requiredBookName :: Text -> Bool
requiredBookName = not . T.null

checkEmail :: Text -> Bool
checkEmail = isJust . T.find (== '@')
