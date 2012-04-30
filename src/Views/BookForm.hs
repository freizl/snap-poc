{-# LANGUAGE OverloadedStrings, TemplateHaskell #-}
module BookForm where

import Control.Applicative ((<$>), (<*>))

import Control.Exception (SomeException, try)
import Data.ByteString (ByteString)
import Data.Lens.Template
import Data.Text (Text)
import Snap.Http.Server (defaultConfig, httpServe)
import Snap.Snaplet
import Snap.Snaplet.Heist
import System.IO (hPutStrLn, stderr)
import Text.Digestive
import Text.Digestive.Heist
import Text.Digestive.Snap
import Text.Templating.Heist
import qualified Data.Text as T

data Lang = EN | CN
    deriving (Eq, Show)
             
data Book = Book
    { bookName :: Text
    , description :: Text
    , language :: Lang
    } deriving (Show)

userForm :: Monad m => Form Text m Book
userForm = Book
    <$> "name" .: text (Just "Real World Haskell")
    <*> "description" .: text Nothing
    <*> "sex" .: choice [(EN, "English"), (CN, "Chinese")] Nothing
