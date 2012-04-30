{-# LANGUAGE OverloadedStrings, ExtendedDefaultRules #-}

module Controllers.Book where

import           Control.Applicative
import           Control.Monad.Trans
import           Control.Monad.State
import           Data.ByteString (ByteString)
import           Data.Maybe
import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import           Data.Time.Clock
import           Snap.Core
import           Snap.Snaplet.Auth.Backends.JsonFile
import           Snap.Snaplet.Auth
import           Snap.Snaplet
import           Snap.Snaplet.Heist
import           Snap.Snaplet.Session
import           Snap.Util.FileServe
import           Text.Templating.Heist
import           Text.XmlHtml hiding (render)

import           Application
import           Models.Product
import           Models.Order
import           Controllers.Utils
--import           Views.BookForm

----------------------------------------------------------------------
-- | render create product form

book :: AppHandler ()
book = redirect "/"
--    (view, result) <- runForm "form" bookForm
--    case result of
--        Just x -> heistLocal (bindUser x) $ render "book"
--        Nothing -> heistLocal (bindDigestiveSplices view) $ render "book-form"
--  where
--    bindUser = bindString "book" . T.pack . show

addBook :: AppHandler ()
addBook = redirect "/"


------------------------------------------------------------------------------
-- | Get product
getProduct :: AppHandler ()
getProduct = do
    pid   <- decodedParam "pid"
    ps    <- liftIO $ fmap renderDetailP (mockFindProduct pid)
    heistLocal (bindSplices $ pSplices ps) $ render "product"
  where
    pSplices  s = [("showProduct", s)] -- ++ defaultSplices

renderDetailP :: Product -> Splice AppHandler
renderDetailP = renderP

------------------------------------------------------------------------------
-- | List products 
popProductsSplice :: Splice AppHandler
popProductsSplice = do
    ps <- liftIO mockProducts
    -- ps <- DB.getProducts
    mapSplices renderP ps
    
-- | FIXME: producst usally display as 'matrix(3 items per line)' 
--          and pagination rather than simple list
renderP :: Monad m => Product -> Splice m    
renderP p = do 
            runChildrenWithText [("pname", T.decodeUtf8 $ pname p), ("pid", T.decodeUtf8 $ pid p)]


-- | checkoutDone
checkoutDone :: AppHandler ()    
checkoutDone = do
    pid  <- decodedParam "pid"
    od   <- liftIO $ saveOrder pid
    heistLocal (bindString "message" (T.pack $ show od)) $ render "echo"

-- | checkout
checkout :: AppHandler ()
checkout = do
    pid   <- decodedParam "pid"
    ps    <- liftIO $ fmap renderDetailP (mockFindProduct pid)  -- ^ FIXME: duplicated with Product Handler
    heistLocal (bindSplices $ pSplices ps) $ render "checkout"
  where
    pSplices  s = [("showProduct", s)
                  -- ,("current-time", currentTimeSplice)
                  ]


