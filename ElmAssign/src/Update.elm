module Update exposing (..)

import Models exposing (Model)
import Msgs exposing (Msg)
import Shop

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Msgs.None ->
          (model, Cmd.none)
        Msgs.Tick interval time ->
          ({ model | loc_counter = model.loc_counter + (Models.totalEarnings model interval) }, Cmd.none)
        Msgs.Click ->
          ({ model | loc_counter = model.loc_counter + 1 }, Cmd.none)
        Msgs.Purchase item ->
          (Shop.purchase model item, Cmd.none)
