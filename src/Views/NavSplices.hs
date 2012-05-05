{-# LANGUAGE OverloadedStrings #-}

module Views.NavSplices 
  ( addNavSplices
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

--import           Application
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
  
--genNavSplice :: (MonadTrans t, MonadSnap m, Functor (t m), Monad (t m)) =>
 --                              [(B.ByteString, T.Text)] -> t m [X.Node]

genNavSplice links = (:[]) . X.Element "ul" [("class", "nav")] <$> do
  currentURI <- lift $ rqURI <$> getRequest
  -- add the 'active' class if the href is a prefix of the current URI
  let li apath
        | apath `B.isPrefixOf` (currentURI `B.append` "/") =  X.Element "li" [("class", "active")]
        | otherwise = X.Element "li" []
  return $ map (\(pathx, title) -> li pathx [buildLink pathx title]) links
   -- build a link to the path with the given text
    where buildLink pathy title = X.Element "a" [("href", T.decodeUtf8 pathy)] [X.TextNode title]

pages :: [(B.ByteString, T.Text)]
pages = [ ("/index", "Home")
        , ("/book", "Book")
        , ("/echo/About/", "About")
        ]
