module Examples.GeocoderExamples where

import qualified Shared.GeocoderResponseType as Response (GeocoderResult)
import Service.GeoCoder
import Data.ByteString.Lazy.UTF8   (toString)
import Data.Maybe (fromJust)

developerKey =  "insert developerkey here"  

geocodeStreetTest :: IO (Maybe Response.GeocoderResult)
geocodeStreetTest  = geocodeStreet developerKey "Gusshausstrasse, Vienna"
 
