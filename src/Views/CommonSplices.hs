{-# LANGUAGE OverloadedStrings, ExtendedDefaultRules #-}

module Views.CommonSplices where
 
import           Control.Monad.Trans
import           Control.Monad.State
import qualified Data.Text as T
import qualified Data.Text.Encoding as E
import           Data.Time.Clock
import           Text.Templating.Heist
import           Text.XmlHtml hiding (render)

import           Application
import           Models.Product
import           Models.Tag

------------------------------------------------------------------------------
defaultSplices :: [(T.Text, Splice AppHandler)]
defaultSplices = [ 
    ("tagsList",        tagsListSplice)
  , ("start-time",      startTimeSplice)
  , ("current-time",    currentTimeSplice)
  , ("debug-info",      debugSplice)
  , ("popularProducts", popProductsSplice)]

tagsListSplice :: Splice AppHandler
tagsListSplice = do
    tags <- lift getAllTags
    mapSplices renderTag tags


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
-- | Demostrate how to get parameter of a tag
--   Given the node like: <debug-info author="Simon">2</debug-info>    
debugSplice :: Splice AppHandler
debugSplice = do
    input <- getParamNode
    return $ [TextNode $ T.pack $ "Debug: " ++ (getAttrAuthor input)]
  where getAttrAuthor input = case getAttribute "author" input of
          Just x -> show x
          Nothing -> ""

------------------------------------------------------------------------------
-- | List products 
popProductsSplice :: Splice AppHandler
popProductsSplice = do
    ps <- liftIO mockProducts
    -- ps <- DB.getProducts
    mapSplices renderP ps
    

renderTag:: Monad m => Tag -> Splice m
renderTag tag = do
    runChildrenWithText [("name", E.decodeUtf8 $ name tag), ("oid", E.decodeUtf8 $ oid tag)]


-- | FIXME: producst usally display as 'matrix(3 items per line)' 
--          and pagination rather than simple list
renderP :: Monad m => Product -> Splice m    
renderP p = do 
            runChildrenWithText [("pname", E.decodeUtf8 $ productName p), ("pid", E.decodeUtf8 $ productId p)]

