{-# LANGUAGE OverloadedStrings #-}

{-|

This is where all the routes and handlers are defined for your site. The
'app' function is the initializer that combines everything together and
is exported by this module.

-}

module Site
  ( app
  ) where

import           Control.Applicative
import           Control.Concurrent.MVar
import           Control.Monad.State
import           Control.Monad.Trans
import           Data.ByteString (ByteString)
import           Data.Maybe
import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import qualified Database.MongoDB as DB
import           Data.Time.Clock
import           Snap.Core
import           Snap.Snaplet
import           Snap.Snaplet.Auth
import           Snap.Snaplet.Auth.Backends.JsonFile
import           Snap.Snaplet.Heist
import           Snap.Snaplet.MongoDB
import           Snap.Snaplet.Session.Backends.CookieSession
import           Snap.Util.FileServe
import           Text.Templating.Heist
import           Text.XmlHtml hiding (render)

import           Application
import           Handlers

------------------------------------------------------------------------------
-- | The application initializer.
app :: SnapletInit App App
app = makeSnaplet "app" "An snaplet example application." Nothing $ do
    sTime <- liftIO getCurrentTime
    h     <- nestSnaplet "heist" heist $ heistInit "resources/templates"
    mongo <- nestSnaplet "mongoDB" mongoDB $ mongoDBInit (DB.host "localhost") 12 "products"
    s     <- nestSnaplet "session" appSession cookieSessionMgr
    a     <- nestSnaplet "auth" appAuth $ initJsonFileAuthManager defAuthSettings appSession "log/auth.json"    
    addRoutes routes
    addAuthSplices appAuth
    return $ App h sTime mongo s a
  where
    cookieSessionMgr = initCookieSessionManager "log/my-cookies.txt" "myapp-session" (Just 600)

--  pipe  <- liftIO $ DB.runIOE $ DB.connect $ DB.host "localhost"
