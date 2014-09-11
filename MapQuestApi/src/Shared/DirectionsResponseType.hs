{-# LANGUAGE DeriveGeneric,OverloadedStrings #-}
module Shared.DirectionsResponseType where

import GHC.Generics (Generic)
import Data.Aeson
import Shared.ResponseTypes hiding (Options)
import qualified Data.Text as T (Text, toLower)
import Control.Monad (mzero)
import Shared.Leg

data DirectionsResult = DirectionsResult {
 route::Route
 , info::Info
} deriving (Show, Generic)
instance FromJSON DirectionsResult

data Route = Route {
 hasTollRoad :: Bool
 , computedWaypoints::[Point] --TODO test
 , fuelUsed:: Double
 , hasUnpaved:: Bool
 , hasHighway:: Bool
 , realTime:: Double 
 , boundingBox:: BoundingBox
 , distance:: Double
 , time:: Integer
 , locationSequence::[Integer]
 , hasSeasonalClosure:: Bool
 , sessionId:: T.Text
 , locations:: [Location]
 , hasCountryCross:: Bool
 , legs:: [Leg]
 , formattedTime:: T.Text
 , routeError::RouteError 
 , options::Options
 , hasFerry:: Bool
}deriving (Show, Generic)
instance FromJSON Route



data RouteError = RouteError {
 message :: T.Text
 , errorCode :: Integer
}deriving (Show, Generic)
instance FromJSON RouteError

data Options = Options {
  mustAvoidLinkIds:: [LinkId] --TODO test
 , drivingStyle:: Integer
 , countryBoundaryDisplay::Bool
 , generalize:: Integer
 , narrativeType:: T.Text
 , locale:: Locale
 , avoidTimedConditions:: Bool
 , destinationManeuverDisplay:: Bool
 , enhancedNarrative:: Bool
 , filterZoneFactor:: Integer
 , timeType:: Integer
 , maxWalkingDistance:: Integer
 , routeType:: T.Text
 , transferPenalty:: Integer
 , stateBoundaryDisplay:: Bool
 , walkingSpeed:: Integer
 , maxLinkId:: LinkId
 , arteryWeights:: [Double]
 , tryAvoidLinkIds::[LinkId]
 , unit:: Unit
 , routeNumber:: Integer
 , shapeFormat:: T.Text
 , maneuverPenalty:: Integer
 , useTraffic:: Bool
 , returnLinkDirections:: Bool
 , avoidTripIds:: [T.Text] --TODO test
 , manmaps:: T.Text
 , highwayEfficiency:: Integer
 , sideOfStreetDisplay:: Bool
 , cyclingRoadFactor:: Integer
 , urbanAvoidFactor:: Integer
}deriving (Show, Generic)
instance FromJSON Options

data Locale = English_US |
               English_UK |
               French_CA|
               French_FR |
               Germany |
               Spanish_ES |
               Spanish_MEX |
               Russian deriving Show
instance FromJSON Locale where
 parseJSON (String l) 
  | "en_US"== l = return English_US 
  | "en_GB" == l = return English_UK 
  | "fr_CA" == l = return French_CA
  | "fr_FR" == l = return French_FR 
  | "de_DE" == l = return Germany 
  | "es_ES" == l = return Spanish_ES 
  | "es_MX" == l= return Spanish_MEX 
  | "ru_RU" == l = return Russian
 parseJSON _ = mzero
                
data Unit = Miles | Km deriving Show
instance FromJSON Unit where
 parseJSON (String u)
  | "m" == T.toLower u = return Miles
  | "k" == T.toLower u = return Km
 parseJSON _ = mzero
 

 

