{-# LANGUAGE DeriveGeneric, TypeSynonymInstances, FlexibleInstances, MultiParamTypeClasses, OverloadedStrings, NoMonomorphismRestriction #-}
module Service.GeoCoder where


import Data.Aeson  hiding (Result) 
import Data.ByteString.Lazy.UTF8   (toString)
import qualified Data.Text as T (pack)
import Data.ByteString (ByteString)

import Utils.HTTPWrapper
import Request

import qualified Shared.GeocoderRequestType as Request
import qualified Shared.GeocoderResponseType as Response
import qualified Shared.RequestTypes as GenericRequest


defaultParams :: Request.GeocodingParameters
defaultParams = Request.GeocodingParameters {Request.location = GenericRequest.Street {GenericRequest.street = T.pack "Vienna"}, Request.options = Nothing};


geocodeStreet :: String -> String -> (IO (Maybe Response.GeocoderResult))
geocodeStreet devKey street = send devKey params 
 where params = defaultParams {Request.location = GenericRequest.Street {GenericRequest.street = T.pack street}};

                             
instance Request Request.GeocodingParameters Response.GeocoderResult where                             
 send devkey param = do
   let params = [("key", devkey), ("inFormat","json"),("outFormat","json"),("json", toString $ encode param)]
   eitherResponse<- download "http://open.mapquestapi.com/geocoding/v1/address?" params
  -- putStrLn $ show eitherResponse for debugging issues
   either errorHandling parseResponse eitherResponse
    where errorHandling :: String -> IO (Maybe Response.GeocoderResult)
          errorHandling errorMessage = do putStrLn $ "error with download or aeson parsing: "++errorMessage; return Nothing;
          
          parseResponse :: ByteString -> IO (Maybe Response.GeocoderResult)
          parseResponse response = either errorHandling (\x -> return $ Just x) $ eitherDecodeStrict response 

