{-# LANGUAGE TemplateHaskell #-}

{-

This module defines our application's state type and an alias for its handler
monad.

-}

module Application where

import Data.Lens.Template
import Data.Time.Clock
import qualified Snap as Snap
import Snap.Snaplet
import Snap.Snaplet.Heist
import Snap.Snaplet.MongoDB
import Snap.Snaplet.Session

data App = App
    { _heist     :: Snaplet (Heist App)
    , _startTime :: UTCTime
    , _mongoDB   :: Snaplet MongoDBSnaplet
    , _appSession :: Snaplet SessionManager      
    }

type AppHandler = Handler App App

makeLens ''App

instance HasHeist App where
    heistLens = subSnaplet heist

instance HasMongoDBState App where
    getMongoDBState   = with mongoDB Snap.get
    setMongoDBState s = undefined
    --undefined
    -- with mongo $ puts s
