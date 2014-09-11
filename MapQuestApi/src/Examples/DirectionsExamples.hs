module Examples.DirectionsExamples where



import Data.Maybe (fromJust)
import Service.Directions
import qualified Shared.GeocoderRequestType as Request
import qualified Shared.GeocoderResponseType as Response
import qualified Shared.RequestTypes as GenericRequest
import Shared.DirectionsResponseType (legs, route)
import Shared.Leg (maneuvers)

developerKey = "devKey"

testGetDirectionsFromTo = getDirectionsFromTo developerKey from to
 where from = GenericRequest.Point {GenericRequest.lat = 48.198353, GenericRequest.lng = 16.3747}
       to = GenericRequest.Point {GenericRequest.lat = 48.238353, GenericRequest.lng = 16.5047}

getManeuvers = do
 direction <- testGetDirectionsFromTo
 let maneu = mapM maneuvers $ legs.route.fromJust $ direction
 mapM_ (putStrLn.show) maneu