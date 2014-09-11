{-# LANGUAGE DeriveGeneric #-}

{-|
Module      : Service.ResponseTypes
Description : Includes all types needed to parse a MapquestResponse
Copyright   : 
License     : GPL-3
Maintainer  : [abdalla,hahn]@geoinfo.tuwien.ac.at
Stability   : experimental

Here only FromJSON instances are allowed!!
-}
module Shared.ResponseTypes where


import qualified Data.Text as T (Text)
import GHC.Generics (Generic)
import Data.Aeson  hiding (Result) 

type LinkId = Integer

data Point = Point {
 lat:: Double,
 lng:: Double
}deriving (Show,Generic)
instance FromJSON Point

data BoundingBox = BoundingBox {
 ul::Point,
 lr::Point
}deriving (Show,Generic)
instance FromJSON BoundingBox

data Options = Options {
 maxResults:: Maybe Double, -- geocoding
 thumbMaps::Maybe Bool, -- geocoding
 boundingBox::Maybe BoundingBox,
 ignoreLatLngInput :: Maybe Bool -- geocoding
}deriving (Show,Generic)
instance FromJSON Options



data Info = Info {
 statuscode :: Integer
 , copyright ::  Copyright
 , messages :: [T.Text]
}deriving (Show,Generic)
instance FromJSON Info

data Copyright = Copyright {
 text:: T.Text,
 imageUrl::T.Text,
 imageAltText:: T.Text
}deriving (Show,Generic)
instance FromJSON Copyright


-- | used by geocoding and directions
data Location = Location {
 latLng::Point
 , street:: T.Text
 , adminArea6 :: Maybe T.Text 
 , adminArea5:: Maybe T.Text
 , adminArea4:: Maybe T.Text
 , adminArea3:: Maybe T.Text 
 , adminArea1:: Maybe T.Text
 , adminArea6Type:: Maybe T.Text
 , adminArea5Type:: Maybe T.Text 
 , adminArea4Type:: Maybe T.Text 
 , adminArea3Type:: Maybe T.Text
 , adminArea1Type:: Maybe T.Text
 , postalCode:: T.Text
 --, type :: T.Text TODO is a Haskell keyword 
 , dragPoint :: Bool
 , displayLatLng ::Point
 , geocodeQuality :: GeocodeQuality
 , geocodeQualityCode ::T.Text -- ^ refer to http://open.mapquestapi.com/geocoding/geocodequality.html
 , linkId :: LinkId -- TODO
 , sideOfStreet :: SideOfStreet
 , mapUrl :: Maybe T.Text
}deriving (Show,Generic)
instance FromJSON Location

-- | 
-- refer to http://open.mapquestapi.com/geocoding/geocodequality.html#granularity
data GeocodeQuality = POINT 
        | ADDRESS
        | INTERSECTION
        | STREET
        | COUNTRY
        | STATE
        | COUNTY
        | CITY
        | NEIGHBORHOOD
        | ZIP
        | ZIP_EXTENDED deriving (Show,Generic)
instance FromJSON GeocodeQuality

data SideOfStreet = L | R | N  deriving (Show,Generic)
instance FromJSON SideOfStreet



