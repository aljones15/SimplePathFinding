module Main where

import Lib
import Control.Monad
import Control.Monad.IO.Class

main :: IO ()
main = do
  tiles <- insertRandomGoal rows columns
  directions <- insertRandomPlayer rows columns
  runCurses $ do
    setEcho False
    w <- defaultWindow
    updateWindow w $ do
      drawTitle 1 1 breadthFirstTitle
      mapCursorText (toInteger rows) 1 2 tiles
      mapCursorText (toInteger rows) 30 2 directions
    render
    waitFor w (\ev -> ev == EventCharacter 'q' || ev == EventCharacter 'Q')
