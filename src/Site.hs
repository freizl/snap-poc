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
import           Snap.Snaplet.Session.Backends.CookieSession
import           Snap.Util.FileServe
import           Text.Templating.Heist
import           Text.XmlHtml hiding (render)
import           Control.Concurrent.MVar
import qualified Database.MongoDB as DB
import           Snap.Snaplet.MongoDB

import           Application
import           Handlers

------------------------------------------------------------------------------
-- | The application initializer.
app :: SnapletInit App App
app = makeSnaplet "app" "An snaplet example application." Nothing $ do
    sTime <- liftIO getCurrentTime
    h     <- nestSnaplet "heist" heist $ heistInit "resources/templates"
    mongo <- nestSnaplet "mongoDB" mongoDB $ mongoDBInit (DB.host "localhost") 12 "products"
    s <- nestSnaplet "session" appSession $ initCookieSessionManager "log/site-key.txt" "myapp-session" (Just 600)    
    addRoutes routes
    return $ App h sTime mongo s

--  pipe  <- liftIO $ DB.runIOE $ DB.connect $ DB.host "localhost"
