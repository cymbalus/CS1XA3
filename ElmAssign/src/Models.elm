module Models exposing (..)

import Msgs exposing (Msg)

type alias Model = { counter : Int }

init : ( Model, Cmd Msg )
init =
    ({ counter = 0 }, Cmd.none)
