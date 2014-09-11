{-# LANGUAGE DeriveGeneric #-}
{-|
Module      : Shared.RequestTypes
Description : Includes all types needed to create a MapQuest Geocoder request
Copyright   : 
License     : GPL-3
Maintainer  : [abdalla,hahn]@geoinfo.tuwien.ac.at
Stability   : experimental

refer to http://open.mapquestapi.com/geocoding/
-}
module Shared.GeocoderRequestType where

import GHC.Generics (Generic)
import Data.Aeson 

import Shared.RequestTypes

data GeocodingParameters = GeocodingParameters {
  location::Street, 
  options::Maybe Options'  
}deriving (Show,Generic)
instance ToJSON GeocodingParameters