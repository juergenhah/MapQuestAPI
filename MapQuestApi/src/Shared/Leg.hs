{-# LANGUAGE DeriveGeneric #-}
module Shared.Leg where

import Data.Aeson (FromJSON)
import GHC.Generics (Generic)
import qualified Data.Text as T (Text)
import Shared.Maneuver

data Leg = Leg {
 hasTollRoad:: Bool
 , index:: Integer
 , roadGradeStrategy:: [[T.Text]] -- TODO test
 , hasHighway:: Bool
 , hasUnpaved:: Bool
 , distance:: Double
 , time:: Integer --TODO test
 , origIndex:: Integer
 , hasSeasonalClosure::Bool
 , origNarrative:: T.Text
 , hasCountryCross:: Bool
 , formattedTime:: T.Text
 , destNarrative:: T.Text
 , destIndex:: Integer
 , maneuvers::[Maneuver]
 , hasFerry:: Bool
}deriving (Show, Generic) 
instance FromJSON Leg 