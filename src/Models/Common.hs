{-# LANGUAGE OverloadedStrings #-}

module Models.Common where

import           Database.MongoDB
import           Data.String (IsString)
import qualified Snap.Snaplet.MongoDB as DB
import qualified Data.ByteString as BS
import qualified Data.Text as T
import qualified Data.Text.Encoding as E

dbname :: IsString s => s
dbname = "products"
  
withDB :: DB.MonadMongoDB m => Action IO a -> m (Either Failure a)
withDB = DB.withDB

-- | FIXME: `show` will enclose " which is bad to UI
fetchValue :: Label -> Document -> BS.ByteString
fetchValue l d = stringToBS $ show  $ valueAt l d

fetchList :: DB.MonadMongoDB m 
          => Collection 
          -> (Document -> a) 
          -> m [a]
fetchList tname fn = do
    results <- ( withDB $ find (select [] tname) >>= rest )
    return $ datas results fn
  where
    datas (Left _) _   = []
    datas (Right r) f = map f r

bs2String :: BS.ByteString -> String
bs2String = T.unpack . E.decodeUtf8

stringToBS :: String -> BS.ByteString
stringToBS =  E.encodeUtf8 . T.pack
