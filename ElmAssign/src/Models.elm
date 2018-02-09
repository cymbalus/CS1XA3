module Models exposing (..)

import List exposing (map)
import Msgs exposing (Msg)
import Clickers exposing (earnings)
import Upgrades exposing (modifiers)
import Types exposing (Clicker, Upgrade, ClickerData)

type alias Model =
  { loc_counter : Float
  , clickers : List ClickerData
  , multiplier : Float
  , remaining_upgrades : List Upgrade
  , active_upgrades : List Upgrade
  }

init : ( Model, Cmd Msg )
init =
  ({ loc_counter = 0
   , clickers = Clickers.init
   , multiplier = 1.0
   , remaining_upgrades = Upgrades.list
   , active_upgrades = []
  }, Cmd.none)

clickerData : Model -> Clicker -> Maybe ClickerData
clickerData model clicker =
  let
    search clickers = case clickers of
      [] ->
        Nothing
      ((c, q, m)::cs) ->
        if c == clicker then
          Just (c, q, m)
        else
          search cs
  in
    search (model.clickers)

clickerEarnings : Model -> Clicker -> Float
clickerEarnings model clicker =
  let
    data = clickerData model clicker
  in
    case data of
      Nothing ->
        0.0
      Just (c, q, m) ->
        (earnings c) * m * (toFloat q)

applyUpgrade : Model -> Upgrade -> Model
applyUpgrade model upgrade =
  applyModifiers model (modifiers upgrade)

applyModifiers : Model -> (List Clicker, Float) -> Model
applyModifiers model modifiers = case modifiers of
  ([], _) ->
    model
  ((c::cs), multiplier) ->
    let
      -- Function for map to apply to selectively
      -- update clicker tuples
      updateClicker clicker multiplier entry =
        let
          (c, q, m) = entry
        in
          if clicker == c then
            (c, q, m + multiplier)
          else
            entry
    in
      applyModifiers { model | clickers = map (updateClicker c multiplier) model.clickers } (cs, multiplier)
