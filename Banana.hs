-- | Collection of helper functions for all examples
module Banana where

import Data.IORef
import Reactive.Banana

-- | Create sink function and function to register callbacks.
makeSink :: IO (a -> IO (), (a -> IO ()) -> IO ())
makeSink = do
  ref <- newIORef (\_ -> return ())
  return ( \x -> ($ x) =<< readIORef ref
         , writeIORef ref
         )
-- FIXME: maybe following code should be used instead for thread safety: 
--     > atomicModifyIORef ref . const

