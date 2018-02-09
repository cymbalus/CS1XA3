module Main exposing (..)

import Html exposing (program)
import Msgs exposing (Msg)
import Models exposing (Model, init)
import Update exposing (update)
import View exposing (view)

{- Subscriptions -}
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

{- Main -}
main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
