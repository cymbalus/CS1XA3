module Update exposing (..)

import Models exposing (Model)
import Msgs exposing (Msg)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Msgs.None ->
          (model, Cmd.none)
        Msgs.Click ->
          ({ model | counter = model.counter + 1 }, Cmd.none)
