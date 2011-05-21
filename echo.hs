-- | Echo program. It prints back every string passed to it. 
import Control.Applicative
import Control.Monad
import Reactive.Banana

import Banana (makeSink)


main :: IO ()
main = do
  (sink,handler) <- makeSink
  -- Prepare network
  prepareEvents $ do
    evt <- fromAddHandler handler
    reactimate $ putStrLn <$> evt
  -- Run forever
  forever $ sink =<< getLine
