{-# LANGUAGE OverloadedStrings, ExtendedDefaultRules #-}

module Controllers.Home where

import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import           Snap.Core
import           Snap.Snaplet.Auth
import           Snap.Snaplet
import           Snap.Snaplet.Heist
import           Snap.Snaplet.Session
import           Text.Templating.Heist
import           Text.XmlHtml hiding (render)
import           Application
import           Controllers.Utils
import           Views.CommonSplices

------------------------------------------------------------------------------
-- | The application's routes.

-- | work around for highlight home nav
home :: AppHandler ()
home = redirect "/index"

------------------------------------------------------------------------------
-- | FIXME: add global splices for login User
index :: AppHandler ()
index = do
    with appSession $ withSession appSession $ setInSession "author" "Simon" 
    user <- with appAuth currentUser    
    ifTop $ heistLocal (bindSplices $ indexSplices user) $ render "home"
  where
    indexSplices user =
        [ ("user-id",         userSplices user)
        ] ++ defaultSplices
    userSplices :: Maybe AuthUser -> Splice AppHandler
    userSplices (Just user) = return $ [TextNode $ userLogin user]
    userSplices Nothing     = return $ []
    
-- FIXME: simplify session usage
--withSession' :: Lens b (Snaplet SessionManager) -> Handler b SessionManager a -> Handler b v a
--withSession' session = withSession session . with session

------------------------------------------------------------------------------
-- | Renders the echo page.
echo :: AppHandler ()
echo = do
    message <- decodedParam "stuff"
    sv <- with appSession $ getFromSession "author"  -- FIXME: dedicated handler display all session values
    heistLocal (bindString "message" $ concatTexts [(T.decodeUtf8 message), getSessionValue sv]) $ render "echo"
  where
    getSessionValue Nothing = "nothing"
    getSessionValue (Just v) = v
    concatTexts xs = T.intercalate "-" xs
