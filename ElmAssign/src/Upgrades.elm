module Upgrades exposing (..)

import Clickers exposing (Clicker)

type Upgrade = Ubuntu | Emacs | Coffee

list = [
  Ubuntu
  , Emacs
  , Coffee
  ]

modifiers : Upgrade -> (List Clicker, Float)
modifiers upgrade = case upgrade of
  Ubuntu ->
    (Clickers.list, 0.1)
  Emacs ->
    (Clickers.list, 0.5)
  Coffee ->
    ([Clickers.UndergradStudent, Clickers.GradStudent], 0.2)
