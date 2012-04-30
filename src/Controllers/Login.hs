{-# LANGUAGE OverloadedStrings, ExtendedDefaultRules #-}

module Controllers.Login where

import           Snap.Core
import           Snap.Snaplet.Auth
import           Snap.Snaplet
import           Snap.Snaplet.Heist
import           Text.Templating.Heist

import           Application
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
