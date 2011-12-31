{-# LANGUAGE OverloadedStrings, ExtendedDefaultRules #-}

module Handlers(routes) where

import           Control.Applicative
import           Control.Monad.Trans
import           Control.Monad.State
import           Data.ByteString (ByteString)
import           Data.Maybe
import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import           Data.Time.Clock
import           Snap.Core
import           Snap.Snaplet
import           Snap.Snaplet.Heist
import           Snap.Util.FileServe
import           Text.Templating.Heist
import           Text.XmlHtml hiding (render)

import           Application
import qualified DBOperation as DB       -- ^ Always use qualified or not??
import           Models


------------------------------------------------------------------------------
index :: AppHandler ()
index = ifTop $ heistLocal (bindSplices indexSplices) $ render "home"
  where
    indexSplices =
        [ ("start-time",      startTimeSplice)
        , ("current-time",    currentTimeSplice)
        , ("popularProducts", popProductsSplice)
        ] ++ defaultSplices


------------------------------------------------------------------------------
-- | Renders the echo page.
echo :: Handler App App ()
echo = do
    message <- decodedParam "stuff"
    heistLocal (bindString "message" (T.decodeUtf8 message)) $ render "echo"

------------------------------------------------------------------------------
-- | checkoutDone
checkoutDone :: AppHandler ()    
checkoutDone = do
    pid   <- decodedParam "pid"
    -- FIXME Save order
    heistLocal (bindString "message" (T.decodeUtf8 "check out done.")) $ render "echo"

-- | checkout
checkout :: AppHandler ()
checkout = do
    pid   <- decodedParam "pid"
    ps    <- liftIO $ fmap renderDetailP (DB.findProduct pid)
    heistLocal (bindSplices $ pSplices ps) $ render "checkout"
  where
    pSplices  s = [("showProduct", s)
                  ,("current-time", currentTimeSplice)
                  ]

------------------------------------------------------------------------------
-- | Get product
getProduct :: AppHandler ()
getProduct = do
    pid   <- decodedParam "pid"
    ps    <- liftIO $ fmap renderDetailP (DB.findProduct pid)
    heistLocal (bindSplices $ pSplices ps) $ render "product"
  where
    pSplices  s = [("showProduct", s)]

renderDetailP :: Product -> Splice AppHandler
renderDetailP = renderP

------------------------------------------------------------------------------
-- | List products 
popProductsSplice :: Splice AppHandler
popProductsSplice = do
    ps <- liftIO $ DB.products
    mapSplices renderP ps
    
-- | FIXME: producst usally display as 'matrix(3 items per line)' 
--          and pagination rather than simple list
renderP :: Monad m => Product -> Splice m    
renderP p = do runChildrenWithText [("pname", T.pack $ pname p), ("pid", T.pack $ pid p)]


------------------------------------------------------------------------------
defaultSplices = [ ("tagsList", tagsListSplice)]

tagsListSplice :: Splice AppHandler
tagsListSplice = do
    pipe <- gets _dbPipe
    tags <- liftIO $ DB.getAllTags pipe
    mapSplices renderTag tags

renderTag:: Monad m => Tag -> Splice m
renderTag tag = do
    runChildrenWithText [("name", T.pack $ name tag), ("oid", T.pack $ oid tag)]


------------------------------------------------------------------------------
-- | For your convenience, a splice which shows the start time.
startTimeSplice :: Splice AppHandler
startTimeSplice = do
    time <- lift $ gets _startTime
    return $ [TextNode $ T.pack $ show $ time]


------------------------------------------------------------------------------
-- | For your convenience, a splice which shows the current time.
currentTimeSplice :: Splice AppHandler
currentTimeSplice = do
    time <- liftIO getCurrentTime
    return $ [TextNode $ T.pack $ show $ time]


------------------------------------------------------------------------------
-- | The application's routes.
routes :: [(ByteString, Handler App App ())]
routes = [ ("/",            index)
         , ("/echo/:stuff", echo)
         , ("/product/:pid",getProduct)
         ]
         <|>
         -- Checkout sub-site
         [
           ("/checkout/:pid", checkout)
         , ("/checkout/done/", checkoutDone)
         ]
         <|>
         -- FIXME: admin subsite like staticPagesSite
         [ ("", with heist heistServe)
         , ("", serveDirectory "resources/static")
         ]

------------------------------------------------------------------------------
-- UTIL

-- decodedParam :: MonadSnap f => ByteString -> f ByteString
decodedParam p = fromMaybe "" <$> getParam p
