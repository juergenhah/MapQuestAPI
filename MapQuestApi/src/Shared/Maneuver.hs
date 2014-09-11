{-# LANGUAGE DeriveGeneric #-}
module Shared.Maneuver where

import GHC.Generics (Generic)
import Data.Aeson
import Shared.ResponseTypes 
import qualified Data.Text as T (Text)


data Maneuver = Maneuver {
  signs:: [T.Text] -- TODO Test
 , index:: Integer
 , maneuverNotes:: [T.Text] -- TODO test
 , direction:: Integer
 , narrative:: T.Text
 , iconUrl:: T.Text
 , distance:: Double
 , time:: Integer
 , linkIds:: [LinkId]
 , streets:: [T.Text]
 , attributes:: Integer
 , transportMode:: T.Text
 , formattedTime:: T.Text
 , directionName:: T.Text
 , mapUrl:: Maybe T.Text
 , startPoint:: Point
 , turnType:: Integer
} deriving (Show, Generic)
instance FromJSON Maneuver 
