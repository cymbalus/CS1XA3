module Update exposing (..)

import Models exposing (Model)
import Msgs exposing (Msg)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Msgs.None ->
          (model, Cmd.none)
        Msgs.Click ->
          ({ model | loc_counter = model.loc_counter + 1 }, Cmd.none)
