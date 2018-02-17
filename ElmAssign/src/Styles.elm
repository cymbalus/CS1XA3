module Styles exposing (..)

import Html exposing (..)

gridContainer =
   [ ("padding", "0px")
   , ("margin", "0px")
   , ("width", "100%")
   ]

gridCol =
  [ ("height", "100vh")
  ]

sideCol = gridCol ++
  [ ("box-shadow", "0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)")
  ]

curtisImg =
  [ ("display", "block")
  , ("margin-top", "200px")
  , ("margin-left", "auto")
  , ("margin-right", "auto")
  , ("width", "25%")
  ]
