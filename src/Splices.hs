{-# LANGUAGE OverloadedStrings #-}

module Splices 
  (addNavSplices
  ) where

import           Control.Applicative
import           Control.Monad.Trans
import qualified Data.Text as T
import qualified Data.Text.Encoding as T

import           Snap.Core
import           Snap.Snaplet
import           Snap.Snaplet.Heist
import qualified Text.XmlHtml as X
import qualified Data.ByteString as B

import           Application
------------------------------------------------------------------------------
-- | Add standard nav splices to a Heist-enabled application.

-- This adds the following splices:
-- \<nav\>

addNavSplices
  :: HasHeist b
  => Initializer b v ()
addNavSplices = addSplices
  [ ("nav", liftHeist $ genNavSplice pages)
  ]
  
genNavSplice links = (:[]) . X.Element "ul" [("class", "nav")] <$> do
  currentURI <- lift $ rqURI <$> getRequest
  -- add the 'active' class if the href is a prefix of the current URI
  let li path
        | path `B.isPrefixOf` (currentURI `B.append` "/") =  X.Element "li" [("class", "active")]
        | otherwise = X.Element "li" []
  liftIO $ print currentURI                      
  liftIO $ print $ map (\(path, title) -> li path [buildLink path title]) links
  return $ map (\(path, title) -> li path [buildLink path title]) links
   -- build a link to the path with the given text
    where buildLink path title = X.Element "a" [("href", T.decodeUtf8 path)] [X.TextNode title]

pages :: [(B.ByteString, T.Text)]
pages = [ ("/index", "Home")
        , ("/echo/Books/", "Books")
        , ("/echo/About/", "About")
        ]
