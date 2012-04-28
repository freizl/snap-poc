{-# LANGUAGE OverloadedStrings, ExtendedDefaultRules #-}

module Controllers.Routes where

import           Control.Applicative
import           Data.ByteString (ByteString)
import           Data.Maybe (fromMaybe)
import           Snap.Core
import           Snap.Snaplet
import           Snap.Snaplet.Heist
import           Snap.Util.FileServe

import           Application
import           Controllers.Handlers
import           Controllers.Login

routes :: [(ByteString, Handler App App ())]
routes = [ ("/",             index)
         , ("/index",        index)
         , ("/echo/:stuff",  echo)
         , ("/product/:pid", getProduct)
         ]
         <|>
         [ ("/signup", method GET signup <|> method POST addUser)
         , ("/login",  method GET loginGet <|> method POST loginPost)
         , ("/logout", logoff)           
         ]
         <|>
         -- FIXME: Checkout sub-site
         [
           ("/checkout/:pid",  method GET checkout)
         , ("/checkout/done/", method POST checkoutDone)
         ]
         <|>
         [ ("", with heist heistServe)  -- ^ could be just `"" heistServe`
         , ("", serveDirectory "resources/static")
         ]
         -- FIXME: admin subsite like staticPagesSite
