module Msgs exposing (..)

import Time exposing (Time, second)
import Types exposing (..)

type Msg =
  None
  | Tick Time Time
  | Click
  | Purchase ShopItem
