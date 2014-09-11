{-# LANGUAGE  TypeSynonymInstances, FlexibleInstances, MultiParamTypeClasses, OverloadedStrings, NoMonomorphismRestriction #-}
module Directions where

import Utils.HTTPWrapper

import Data.Aeson  hiding (Result) 
import Data.ByteString.Lazy.UTF8   (toString)
import Request

import qualified Shared.RequestTypes as GenericRequest
import Shared.DirectionsRequestType as Request
import qualified Shared.DirectionsResponseType as Response
import Data.ByteString (ByteString)
import Data.Maybe (fromJust)
import Shared.DirectionsResponseType (legs, route)
import Shared.Leg (maneuvers)

developerKey = "Fmjtd|luur250b20,2n=o5-9w22g6"

testGetDirectionsFromTo = getDirectionsFromTo developerKey from to
 where from = GenericRequest.Point {GenericRequest.lat = 48.198353, GenericRequest.lng = 16.3747}
       to = GenericRequest.Point {GenericRequest.lat = 48.238353, GenericRequest.lng = 16.5047}

getManeuvers = do
 direction <- testGetDirectionsFromTo
 let maneu = mapM maneuvers $ legs.route.fromJust $ direction
 mapM_ (putStrLn.show) maneu


-- * implementations
getDirectionsFromTo :: String -> GenericRequest.Point -> GenericRequest.Point ->IO (Maybe Response.DirectionsResult)
getDirectionsFromTo devKey start end = send devKey params 
 where params = Request.DirectionsParameters {locations = [start,end ]
                                              , routeType = "shortest"}

instance Request DirectionsParameters (IO (Maybe Response.DirectionsResult)) where
  send devkey param = do
   let params=  [("key", devkey), ("inFormat","json"),("outFormat","json"),("json", toString $ encode param)]
   eitherResponse<- download "http://open.mapquestapi.com/directions/v2/route?" params
   either errorHandling parseResponse eitherResponse
    where errorHandling :: String -> IO (Maybe Response.DirectionsResult)
          errorHandling errorMessage = do putStrLn $ "error with download or aeson parsing: "++errorMessage; return Nothing;
          
          parseResponse :: ByteString -> IO (Maybe Response.DirectionsResult)
          parseResponse response = either errorHandling (\x -> return $ Just x) $ eitherDecodeStrict response 

