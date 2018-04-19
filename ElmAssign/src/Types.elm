module Types exposing (..)

import Time exposing (Time)

type Upgrade = Ubuntu | Emacs | Coffee

type Clicker =
  Macro
  | BashScript
  | UndergradStudent
  | GradStudent
  | Professor
  | ResearchTeam
  | AGI

type alias ClickerData = (Clicker, Int, Float)

type ShopItem =
  ClickerItem Clicker
  | UpgradeItem Upgrade

type alias SerializedModel =
  { loc_counter : Float
  , clickers : List (Int, Int, Float)
  , lastTick : Time
  , remaining_upgrades : List Int
  , active_upgrades : List Int
  }
