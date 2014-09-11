{-# LANGUAGE DeriveGeneric, TypeSynonymInstances, FlexibleInstances, MultiParamTypeClasses, OverloadedStrings, NoMonomorphismRestriction #-}
module Service.GeoCoder where

import Utils.HTTPWrapper
import qualified Data.Text as T (Text,pack,unpack)
import GHC.Generics (Generic)
import Data.Aeson  hiding (Result) 
import Control.Applicative ((<$>), (<*>))
import Data.ByteString.Lazy.UTF8   (toString)
import Request
import System.IO.Unsafe

import Data.ByteString (ByteString)

import qualified Shared.GeocoderRequestType as Request
import qualified Shared.GeocoderResponseType as Response
import qualified Shared.RequestTypes as GenericRequest

developerKey = "Fmjtd|luur250b20,2n=o5-9w22g6"

geocodeStreetTest :: IO (Maybe Response.GeocoderResult)
geocodeStreetTest  = geocodeStreet developerKey "Gusshausstrasse, Vienna"
 
defaultParams :: Request.GeocodingParameters
defaultParams = Request.GeocodingParameters {Request.location = GenericRequest.Street {GenericRequest.street = T.pack "Vienna"}, Request.options = Nothing};

testoptions = GenericRequest.MR 3 (GenericRequest.TMaps True GenericRequest.End)

geocodeStreet :: String -> String -> (IO (Maybe Response.GeocoderResult))
geocodeStreet devKey street = send devKey params 
 where params = defaultParams {Request.location = GenericRequest.Street {GenericRequest.street = T.pack street}};

                             
instance Request Request.GeocodingParameters (IO (Maybe Response.GeocoderResult)) where                             
 send devkey param = do
   let params = [("key", devkey), ("inFormat","json"),("outFormat","json"),("json", toString $ encode param)]
   eitherResponse<- download "http://open.mapquestapi.com/geocoding/v1/address?" params
   either errorHandling parseResponse eitherResponse
    where errorHandling :: String -> IO (Maybe Response.GeocoderResult)
          errorHandling errorMessage = do putStrLn $ "error with download or aeson parsing: "++errorMessage; return Nothing;
          
          parseResponse :: ByteString -> IO (Maybe Response.GeocoderResult)
          parseResponse response = either errorHandling (\x -> return $ Just x) $ eitherDecodeStrict response 

