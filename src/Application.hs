{-# LANGUAGE TemplateHaskell #-}

{-

This module defines our application's state type and an alias for its handler
monad.

-}

module Application where

import Data.Lens.Template
import Data.Time.Clock

import Snap.Snaplet
import Snap.Snaplet.Heist

import Control.Concurrent.MVar
import Database.MongoDB

data App = App
    { _heist :: Snaplet (Heist App)
    , _startTime :: UTCTime
    , _dbPipe :: Pipe
    }

type AppHandler = Handler App App

makeLens ''App

instance HasHeist App where
    heistLens = subSnaplet heist

