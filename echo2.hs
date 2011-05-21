-- | Echo program. It prints back every string passed to it. 
import Control.Applicative
import Control.Monad
import Data.IORef
import Data.Function
import Reactive.Banana

import Banana (makeSink)

import Prelude hiding (filter)

main :: IO ()
main = do
  (sink,handler) <- makeSink
  done           <- newIORef False
  -- Prepare network
  prepareEvents $ do
    evt <- fromAddHandler handler
    reactimate $ putStrLn <$> evt
    reactimate $ const (writeIORef done True) <$> filter null evt
  -- Main loop
  fix $ \cont -> do
    complete <- readIORef done
    unless complete $ do
      getLine >>= sink >> cont
