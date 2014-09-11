{-# LANGUAGE DeriveGeneric #-}
{-|
Module      : Shared.RequestTypes
Description : Includes all types needed to create a MapQuest Geocoder response
Copyright   : 
License     : GPL-3
Maintainer  : [abdalla,hahn]@geoinfo.tuwien.ac.at
Stability   : experimental

refer to http://open.mapquestapi.com/geocoding/
-}
module Shared.GeocoderResponseType where


import qualified Data.Text as T (Text)
import GHC.Generics (Generic)
import Data.Aeson  hiding (Result) 
import Shared.ResponseTypes

data GeocoderResult =  GeocoderResult {
 info::Info,
 options::Options,
 results::[Result]
}deriving (Show,Generic)
instance FromJSON GeocoderResult


data Result = Result {
 providedLocation::Street,
 locations::[Location] 
}deriving (Show,Generic)
instance FromJSON Result

data Loc = Loc{
 location :: T.Text
}deriving (Show,Generic)
instance FromJSON Loc

data Street = Street {
 street::T.Text
}deriving (Show,Generic)
instance FromJSON Street


