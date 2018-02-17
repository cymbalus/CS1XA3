module Msgs exposing (..)

import Time exposing (Time, second)
import Types exposing (..)

import Bootstrap.Accordion as Accordion

type Msg =
  None
  | Tick Time Time
  | Click
  | Purchase ShopItem
  | ClickerAccordion Accordion.State
  | UpgradeAccordion Accordion.State
