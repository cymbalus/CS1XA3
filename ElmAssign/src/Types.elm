module Types exposing (..)

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
