{-# LANGUAGE  TypeSynonymInstances, FlexibleInstances, MultiParamTypeClasses, OverloadedStrings, NoMonomorphismRestriction #-}
module Service.Directions where



import Data.Aeson  hiding (Result) 
import Data.ByteString.Lazy.UTF8   (toString)
import Data.ByteString (ByteString)

import Utils.HTTPWrapper
import Request

import qualified Shared.RequestTypes as GenericRequest
import qualified Shared.DirectionsRequestType as Request
import qualified Shared.DirectionsResponseType as Response



getDirectionsFromTo :: String -> GenericRequest.Point -> GenericRequest.Point ->IO (Maybe Response.DirectionsResult)
getDirectionsFromTo devKey start end = send devKey params 
 where params = Request.DirectionsParameters {Request.locations = [start,end ]
                                              , Request.routeType = "shortest"}

instance Request Request.DirectionsParameters Response.DirectionsResult where
  send devkey param = do
   let params=  [("key", devkey), ("inFormat","json"),("outFormat","json"),("json", toString $ encode param)]
   eitherResponse<- download "http://open.mapquestapi.com/directions/v2/route?" params
   -- putStrLn $ show eitherResponse for debugging issues
   either errorHandling parseResponse eitherResponse
    where errorHandling :: String -> IO (Maybe Response.DirectionsResult)
          errorHandling errorMessage = do putStrLn $ "error with download or aeson parsing: "++errorMessage; return Nothing;
          
          parseResponse :: ByteString -> IO (Maybe Response.DirectionsResult)
          parseResponse response = either errorHandling (\x -> return $ Just x) $ eitherDecodeStrict response 

