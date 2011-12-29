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
import           DBOperation
import           Models


------------------------------------------------------------------------------
index :: Handler App App ()
index = ifTop $ heistLocal (bindSplices indexSplices) $ render "home"
  where
    indexSplices =
        [ ("start-time",      startTimeSplice)
        , ("current-time",    currentTimeSplice)
        , ("popularProducts", popProductsSplice)
        ] ++ defaultSplices


------------------------------------------------------------------------------
-- | get product
-- eeee
getProduct :: Handler App App ()
getProduct = do
    pid <- decodedParam "pid"
    heistLocal (bindSplices pSplices) $ render "product"
  where
    decodedParam p = fromMaybe "" <$> getParam p
    pSplices       = [("showProduct", getProduct')]

getProduct' :: Splice AppHandler
getProduct' = do
    p <- return (products !! (read "1"))
    renderDetailP p
    
renderDetailP  =  renderP


------------------------------------------------------------------------------

popProductsSplice :: Splice AppHandler
popProductsSplice = do
    ps <- return products
    mapSplices renderP ps
    
-- | FIXME: producst usally display as 'matrix' rather than simple list
renderP :: Monad m => Product -> Splice m    
renderP p = do runChildrenWithText [("pname", T.pack $ pname p), ("pid", T.pack $ pid p)]


------------------------------------------------------------------------------
defaultSplices = [ ("tagsList", tagsListSplice)]

tagsListSplice :: Splice AppHandler
tagsListSplice = do
    pipe <- gets _dbPipe
    tags <- liftIO $ getAllTags pipe
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
-- | Renders the echo page.
echo :: Handler App App ()
echo = do
    message <- decodedParam "stuff"
    heistLocal (bindString "message" (T.decodeUtf8 message)) $ render "echo"
  where
    decodedParam p = fromMaybe "" <$> getParam p


------------------------------------------------------------------------------
-- | The application's routes.
routes :: [(ByteString, Handler App App ())]
routes = [ ("/",            index)
         , ("/echo/:stuff", echo)
         , ("/product/:id",getProduct)
         ]
         <|>
         -- FIXME: admin subsite like staticPagesSite
         [ ("", with heist heistServe)
         , ("", serveDirectory "resources/static")
         ]

