{-# LANGUAGE MultiParamTypeClasses, FunctionalDependencies #-}
module Request where

import Data.Aeson (FromJSON, ToJSON)


class (ToJSON a) => Request  a b | a-> b where
 
  send :: String -> a -> b
 
