{-# LANGUAGE MultiParamTypeClasses, FunctionalDependencies #-}
module Request where

import Data.Aeson (FromJSON, ToJSON)


class (ToJSON a, FromJSON b) => Request  a b | a-> b where

  send :: String -> a -> IO (Maybe b)
 
