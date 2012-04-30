{-# LANGUAGE OverloadedStrings, ExtendedDefaultRules #-}

module Controllers.Book where


import           Control.Monad.Trans
import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import           Snap.Core
import           Snap.Snaplet.Heist
import           Text.Templating.Heist

import           Application
import           Models.Product
import           Models.Order
import           Controllers.Utils

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
renderDetailP p = do 
            runChildrenWithText [("pname", T.decodeUtf8 $ productName p), ("pid", T.decodeUtf8 $ productId p)]


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
