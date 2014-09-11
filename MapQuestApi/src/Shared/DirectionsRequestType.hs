{-# LANGUAGE DeriveGeneric #-}
module Shared.DirectionsRequestType where

import GHC.Generics (Generic)
import Data.Aeson 

import Shared.RequestTypes

data DirectionsParameters = DirectionsParameters {
  locations :: [Point],
  routeType :: String
} deriving (Show,Generic)
instance ToJSON DirectionsParameters
