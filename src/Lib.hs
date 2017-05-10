module Lib
    ( rows,
      columns,
      GraphTitle,
      breadthFirstTitle,
      dijkstraTitle,
      aTitle,
      roll,
      Compass,
      Cartogram,
      getRandomCompass,
      constructCompass,
      insertRandomPlayer,
      TerrianType,
      Terrian,
      getRandomTerrian,
      constructTerrian,
      insertRandomGoal,
      initMap,
      drawShow,
      mapCursorText,
      drawTitle,
      waitFor
    ) where

  import UI.NCurses
  import Control.Monad
  import Control.Monad.IO.Class
  import System.Random 

  -- Tutorials
  -- working on several path findng algorithims
  -- http://www.redblobgames.com/pathfinding/a-star/introduction.html

  -- | 'rows' the number of rows in the environment
  rows = 10 :: Int

  -- | 'columns' the number of columns in the environment
  columns = 10 :: Int

  -- | 'GraphTitle' a String representing the Title of a Graph
  type GraphTitle = String
  breadthFirstTitle = "Breadth First Search"
  dijkstraTitle = "Dijkstra's Algorithm"
  aTitle = "A*"

  -- | 'roll' gets a random int from 1 to the parameter
  roll :: Int -> IO Int
  roll m 
    | m <= 0 = getStdRandom (randomR (1,1)) 
    | m > 0 = getStdRandom (randomR (1,m))

  -- | The 'Compass' data type provides breadcrumbs from the goal to the start. 
  data Compass = N | S | E | W | U deriving (Show, Eq)

  -- | 'Cartogram' is a list of compass directions that mirrors the terrian.
  type Cartogram = [Compass]

  -- | 'getRandomCompass' gets a list of Random Compass points
  getRandomCompass :: Int -> Compass
  getRandomCompass 1 = N
  getRandomCompass 2 = S
  getRandomCompass 3 = E
  getRandomCompass 4 = W
  getRandomCompass _ = N

  -- | 'insertRandomPlayer' inserts a random player into the Cartogram
  insertRandomPlayer :: Int-> Int -> IO Cartogram
  insertRandomPlayer n1 n2 = do
    c <- constructCompass n1 n2
    r <- roll $ (length c) - 1
    return $ (take r c) ++ U : (drop r c)

  -- | 'constructCartogram' makes a list of random Compass points
  constructCompass :: Int -> Int -> IO Cartogram
  constructCompass n1 n2 = do
    r <- replicateM (n1 * n2) (roll 4)
    return $ map getRandomCompass r

  -- | 'TerrianType' determines how hard a cell is to traverse.
  data TerrianType = D | F | P | G deriving (Show, Eq)

  -- | 'Terrian' is a list of TerrianTypes with a single goal.
  type Terrian = [TerrianType]
  
  -- | 'getRandomTerrian' gets a random TerrianType 
  getRandomTerrian :: Int -> TerrianType
  getRandomTerrian 1 = F
  getRandomTerrian 2 = D
  getRandomTerrian 3 = P
  getRandomTerrian _ = F

  -- | 'constructTerrian' constructs a list of random TerrianTypes
  constructTerrian :: Int -> Int -> IO Terrian
  constructTerrian n1 n2 = do 
     r <- replicateM (n1 * n2) (roll 3)
     return $ map getRandomTerrian r

  -- | 'insertRandomGoal' inserts a Goal into the Terrian
  insertRandomGoal :: Int-> Int -> IO Terrian
  insertRandomGoal n1 n2 = do
    c <- constructTerrian n1 n2
    r <- roll $ (length c) - 1
    return $ (take r c) ++ G : (drop r c)

  -- | 'initMap' initials a Map with rows, cols, a glyph, and a construct func
  initMap :: Int -> Int -> a -> (Int -> Int -> IO [a]) -> IO [a]
  initMap row col glyph constructor = do
    c <- constructor row col
    r <- roll $ (length c) - 1
    return $ (take r c) ++ glyph : (drop r c)

  -- | 'drawShow' turns anything that can be shown into an update
  drawShow :: Show a => a -> Update ()
  drawShow a = drawString $ show a ++ " "

  -- | 'mapCursorText' maps the columns and rows to ncurse strings
  mapCursorText :: Show a => Integer -> Integer -> Integer -> [a] -> Update [()]
  mapCursorText row xOffSet yOffSet terrian
    | row <= 1 = do 
      moveCursor (row + yOffSet) xOffSet
      mapM drawShow $ take rows terrian
    | row > 1 = do
      moveCursor (row + yOffSet) xOffSet
      mapM drawShow $ take rows terrian
      mapCursorText (row - 1) xOffSet yOffSet (drop rows terrian)

  -- | 'drawTitle' draws a title in the window
  drawTitle :: Integer -> Integer -> GraphTitle -> Update ()
  drawTitle x y title = do
    moveCursor x y
    drawString title
  
  -- | 'waitFor' watis for a q KeyStroke to quit 
  waitFor :: Window -> (Event -> Bool) -> Curses ()
  waitFor w p = loop where
    loop = do
      ev <- getEvent w Nothing
      case ev of
        Nothing -> loop
        Just ev' -> if p ev' then return () else loop
