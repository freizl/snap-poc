{-# LANGUAGE OverloadedStrings, ExtendedDefaultRules #-}

module Controllers.Login where

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
import qualified Models.DBOperation as DB       -- ^ Always use qualified or not??
import           Models.Models
import           Controllers.Utils

------------------------------------------------------------------------------
-- | Auth
signup :: AppHandler ()
signup = do
    heistLocal (bindString "test" "Sign Up") $ render "signup"
    
-- | FIXME: required field validation    
addUser :: AppHandler ()
addUser = do
    with appAuth $ registerUser "username" "password"
    redirect "/"

-- | FIXME: ERROR Handler, e.g. user doesnot exists, password incorrect
--   FIXME: use `loginUser` function
loginPost :: AppHandler ()
loginPost = do
    userName <- decodedParam "username"
    password <- decodedParam "password"
    with appAuth $ loginByUsername userName (ClearText password) True
    redirect "/"

loginGet :: AppHandler ()
loginGet = do
    heistLocal (bindString "test" "Login") $ render "login"

logoff :: AppHandler ()
logoff = with appAuth $ logoutUser (redirect "/")
