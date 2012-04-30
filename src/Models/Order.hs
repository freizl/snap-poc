{-# LANGUAGE OverloadedStrings, ExtendedDefaultRules #-}

module Models.Order where

import           Data.ByteString (ByteString)
import           Database.MongoDB
import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import qualified Snap.Snaplet.MongoDB as DB

import Application
import Models.Common

data UserOrder = UserOrder
    { orderId   :: String     -- ^ oid
    , orderPid  :: String     -- ^ pid or Product ?? 
    } deriving (Show)

-- | FIXME: saveOrder
saveOrder :: ByteString -> IO UserOrder
-- saveOrder "" = ...  --^ pid could be ""
saveOrder pid = do
  return  UserOrder { orderId = "dumy-order-id", orderPid = bs2String pid}
