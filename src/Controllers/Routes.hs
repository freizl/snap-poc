{-# LANGUAGE OverloadedStrings, ExtendedDefaultRules #-}

module Controllers.Routes where

import           Control.Applicative
import           Data.ByteString (ByteString)
import           Snap.Core
import           Snap.Snaplet
import           Snap.Snaplet.Heist
import           Snap.Util.FileServe

import           Application
import           Controllers.Home
import           Controllers.Login
import           Controllers.Book

routes :: [(ByteString, Handler App App ())]
routes = [ ("/",             index)
         , ("/index",        index)
         , ("/echo/:stuff",  echo)
         ]
         <|>
         [ ("/product/:pid", getProduct)
         ]
         <|>
         [ ("/book", addBook)   -- ^ even URL /book/123 will direct to this handler??
         
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
         , ("", serveDirectory "static")
         ]
         -- FIXME: admin subsite like staticPagesSite
