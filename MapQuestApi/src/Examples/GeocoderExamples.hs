module Examples.GeocoderExamples where

-- TODO 

testoptions = GenericRequest.MR 3 (GenericRequest.TMaps True GenericRequest.End)
developerKey = "insert the devKey here" 

geocodeStreetTest :: IO (Maybe Response.GeocoderResult)
geocodeStreetTest  = geocodeStreet developerKey "Gusshausstrasse, Vienna"
 
 
 developerKey = "put your key here"

testGetDirectionsFromTo = getDirectionsFromTo developerKey from to
 where from = GenericRequest.Point {GenericRequest.lat = 48.198353, GenericRequest.lng = 16.3747}
       to = GenericRequest.Point {GenericRequest.lat = 48.238353, GenericRequest.lng = 16.5047}

getManeuvers = do
 direction <- testGetDirectionsFromTo
 let maneu = mapM maneuvers $ legs.route.fromJust $ direction
 mapM_ (putStrLn.show) maneu
 