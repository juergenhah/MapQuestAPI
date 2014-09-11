{-# LANGUAGE DeriveGeneric #-}
{-|
Module      : Shared.RequestTypes
Description : Includes all types needed to create a MapQuestRequest
Copyright   : 
License     : GPL-3
Maintainer  : [abdalla,hahn]@geoinfo.tuwien.ac.at
Stability   : experimental

Here only ToJSON instances are allowed!!
-}
module Shared.RequestTypes where

import qualified Data.Text as T (Text,pack,unpack)
import GHC.Generics (Generic)
import Data.Aeson  hiding (Result) 
import Control.Monad (mplus)


data Street = Street {
 street::T.Text
}deriving (Show,Generic)
instance ToJSON Street

--data Options = Options {
-- maxResults:: Maybe Double,
-- thumbMaps::Maybe Bool,
-- boundingBox::Maybe BoundingBox,
-- ignoreLatLngInput :: Maybe Bool
--}deriving (Show,Generic)
--instance ToJSON Options

data Options' = MR Double (Options') | TMaps Bool (Options') | BB BoundingBox (Options') | End deriving (Show)

instance ToJSON Options' where
 toJSON = object . tupleType
          where
          tupleType End = []
          tupleType (MR v xs) = [ T.pack "maxResults" .= v]++tupleType xs
          tupleType (TMaps v xs) = [ T.pack "thumbMaps" .= v]++tupleType xs
          tupleType (BB v xs) = [ T.pack "boundingBox" .= toJSON v]++tupleType xs

testoptions = MR 3 (TMaps True (BB BoundingBox {ul=Point{lat=1 ,lng=0},lr=Point{lat=3 ,lng=2}} End))

data BoundingBox = BoundingBox {
 ul::Point,
 lr::Point
}deriving (Show,Generic)
instance ToJSON BoundingBox


data Unit = Miles | Km deriving Show
instance ToJSON Unit where
  toJSON Miles = object [(T.pack "unit") .= (T.pack "m")]
  toJSON Km = object [(T.pack "unit") .= (T.pack "k")]
  
data RouteType = Fastest 
                | Shortest 
                | Pedestrian 
                | MultiModal 
                | Bycicle 
                deriving (Enum,Show) 
                
instance ToJSON RouteType where
  toJSON Fastest = object [T.pack "routeType" .= T.pack "fastest"]
  toJSON Shortest = object [T.pack "routeType" .= T.pack "shortest"]
  toJSON Pedestrian = object [T.pack "routeType" .= T.pack "pedestrian"]
  toJSON MultiModal = object [T.pack "routeType" .= T.pack "multimodal"]
  toJSON Bycicle = object [T.pack "routeType" .= T.pack "bicycle"]
  
data ReverseGeoCode = RGeoC { doReverseGeocode :: Bool } deriving (Show,Generic)
instance ToJSON ReverseGeoCode

data NarrativeType = None |
                       Text |
                       Html |
                       MicroFormat deriving Show
                       
instance ToJSON NarrativeType where
  toJSON None = object [T.pack "narrativeType" .= T.pack "none"]
  toJSON Text = object [T.pack "narrativeType" .= T.pack "text"]
  toJSON Html = object [T.pack "narrativeType" .= T.pack "html"]
  toJSON MicroFormat = object [T.pack "narrativeType" .= T.pack "microformat"]
 
data DrivingStyle = Cautious |
                      Normal |
                      Aggressive deriving Show
                       
instance ToJSON DrivingStyle where
  toJSON Cautious = object [T.pack "drivingStyle" .= T.pack "cautious"]
  toJSON Normal = object [T.pack "drivingStyle" .= T.pack "normal"]
  toJSON Aggressive = object [T.pack "drivingStyle" .= T.pack "aggressive"]
    
  
data EnhancedNarrative = EnhancedNarrative { enhancedNarrative :: Bool} deriving (Show,Generic)
instance ToJSON EnhancedNarrative

data StateBoundaryDisplay = StateBoundaryDisplay { stateBoundaryDisplay :: Bool } deriving (Show,Generic)
instance ToJSON StateBoundaryDisplay

data CountryBoundaryDisplay = CountryBoundaryDisplay { countryBoundaryDisplay :: Bool } deriving (Show,Generic)
instance ToJSON CountryBoundaryDisplay

data DestinationManeuverDisplay = DestinationManeuverDisplay { destinationManeuverDisplay :: Bool } deriving (Show,Generic)
instance ToJSON DestinationManeuverDisplay

data FullShape = FullShape { fullShape :: Bool } deriving (Show,Generic)
instance ToJSON FullShape

data ShapeFormat = ShapeFormat { shapeFormat :: Bool } deriving (Show,Generic)
instance ToJSON ShapeFormat

data InShapeFormat = InShapeFormat { inShapeFormat :: Bool } deriving (Show,Generic)
instance ToJSON InShapeFormat

data OutShapeFormat = OutShapeFormat { outShapeFormat :: Bool } deriving (Show,Generic)
instance ToJSON OutShapeFormat  

data ManMaps = ManMaps { manMaps :: Bool } deriving (Show,Generic)
instance ToJSON ManMaps

data WalkingSpeed = WalkingSpeed { walkingSpeed :: Double } deriving (Show,Generic)
instance ToJSON WalkingSpeed

data HighwayEfficiency = HighwayEfficiency { highwayEfficiency :: Double } deriving (Show,Generic)
instance ToJSON HighwayEfficiency

data Generalize = Generalize { generalize :: Integer } deriving (Show,Generic)
instance ToJSON Generalize

data CyclingRoadFactor = CyclingRoadFactor { cyclingRoadFactor :: Double } deriving (Show,Generic)
instance ToJSON CyclingRoadFactor

data RoadGradeStrategy = DEFAULT_STRATEGY | 
                            AVOID_UP_HILL |
                            AVOID_DOWN_HILL |
                            AVOID_ALL_HILLS |
                            FAVOR_UP_HILL |
                            FAVOR_DOWN_HILL |
                            FAVOR_ALL_HILLS deriving Show
                            
instance ToJSON RoadGradeStrategy where

        toJSON rg = object [T.pack "roadGradeStrategy" .= T.pack (show rg)]

data MaxLinkId = MaxLinkId { maxLinkId :: Integer } deriving (Show,Generic)
instance ToJSON MaxLinkId

data Locale = English_US |
               English_UK |
               French_CA|
               French_FR |
               Germany |
               Spanish_ES |
               Spanish_MEX |
               Russian deriving Show
               
instance ToJSON Locale where
        toJSON English_US = object [T.pack "locale" .= T.pack "en_US"]
        toJSON English_UK = object [T.pack "locale" .= T.pack "en_GB"]
        toJSON French_CA = object [T.pack "locale" .= T.pack "fr_CA"]
        toJSON French_FR = object [T.pack "locale" .= T.pack "fr_FR"]
        toJSON Germany = object [T.pack "locale" .= T.pack "de_DE"]
        toJSON Spanish_ES = object [T.pack "locale" .= T.pack "es_ES"]
        toJSON Spanish_MEX = object [T.pack "locale" .= T.pack "es_MX"]
        toJSON Russian = object [T.pack "locale" .= T.pack "ru_RU"]
        
data Avoids = Avoids { avoids :: [Choices] } deriving (Show,Generic)
instance ToJSON Avoids

data Choices = LimitedAccess | TollRoad | Ferry | Unpaved | SeasonalClosure | CountryCrossing  deriving Show
instance ToJSON Choices where
        toJSON LimitedAccess = toJSON $ T.pack "Limited Access"
        toJSON TollRoad = toJSON$ T.pack  "Toll Road"
        toJSON SeasonalClosure = toJSON $ T.pack "Seasonal Closure"
        toJSON CountryCrossing = toJSON $ T.pack "Country Crossing"
        toJSON c = toJSON $ show c 
        
data TryAvoidLinkIds = TryAvoidLinkIds { tryAvoidLinkIds :: [Int]} deriving (Show,Generic)
instance ToJSON TryAvoidLinkIds

data MustAvoidLinkIds = MustAvoidLinkIds { mustAvoidLinkIds :: [Int]} deriving (Show,Generic)
instance ToJSON MustAvoidLinkIds

data Point = Point {
 lat:: Double,
 lng:: Double
}deriving (Show,Generic)
instance ToJSON Point where
 toJSON p = toJSON $ (show $ lat p)++","++(show $ lng p) 
