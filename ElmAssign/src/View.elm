module View exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Models exposing (Model)
import Msgs exposing (Msg)

view : Model -> Html Msg
view model =
  div []
      [ div []
      [
        text (toString model.counter)
      ],
        button [ onClick Msgs.Click ] [ text "+" ]
      ]
