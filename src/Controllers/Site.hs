{-# LANGUAGE OverloadedStrings #-}

module Controllers.Site
  ( app
  ) where

import           Control.Monad.Trans
import qualified Database.MongoDB as DB
import           Data.Time.Clock
import           Snap.Snaplet
import           Snap.Snaplet.Auth
import           Snap.Snaplet.Auth.Backends.JsonFile
import           Snap.Snaplet.Heist
import           Snap.Snaplet.MongoDB
import           Snap.Snaplet.Session.Backends.CookieSession

import           Application
import           Controllers.Routes (routes)
import           Views.NavSplices

------------------------------------------------------------------------------
-- | The application initializer.
app :: SnapletInit App App
app = makeSnaplet "app" "An snaplet example application." Nothing $ do
    sTime <- liftIO getCurrentTime
    h     <- nestSnaplet "heist" heist $ heistInit "resources/templates"
    mdb   <- nestSnaplet "mongoDB" mongoDB $ mongoDBInit (DB.host "localhost") 12 "products"
    s     <- nestSnaplet "session" appSession cookieSessionMgr
    a     <- nestSnaplet "auth" appAuth $ initJsonFileAuthManager defAuthSettings appSession "log/auth.json"    
    addRoutes routes
    addAuthSplices appAuth
    addNavSplices
    return $ App h sTime mdb s a
  where
    cookieSessionMgr = initCookieSessionManager "log/my-cookies.txt" "myapp-session" (Just 600)

--  pipe  <- liftIO $ DB.runIOE $ DB.connect $ DB.host "localhost"
