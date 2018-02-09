module Upgrades exposing (..)

import Types exposing (..)
import Clickers

list : List Upgrade
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
    ([UndergradStudent, GradStudent], 0.2)

cost : Upgrade -> Int
cost upgrade = case upgrade of
  Ubuntu ->
    100
  Emacs ->
    100
  Coffee ->
    1000
