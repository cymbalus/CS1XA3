module Main exposing (..)

import Html exposing (program)
import Msgs exposing (Msg)
import Models exposing (Model, init)
import Update exposing (update)
import View exposing (view)
import Time exposing (Time, second)

tickRate : Time
tickRate = second / 30

{- Subscriptions -}
subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every tickRate (Msgs.Tick tickRate)

{- Main -}
main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
