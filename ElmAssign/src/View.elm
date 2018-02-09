module View exposing (..)

import Html exposing (..)
import List
import Html.Events exposing (onClick)
import Models exposing (Model)
import Clickers exposing (Clicker, ClickerData)
import Msgs exposing (Msg)

{-
Temporary view for testing purposes
-}
view : Model -> Html Msg
view model =
  div []
      [ div []
          [
            text (toString model.loc_counter)
          ]
        , button [ onClick Msgs.Click ] [ text "+" ]
        , br [] []
        , div []
            (List.map clickerDiv model.clickers)
      ]

clickerDiv : ClickerData -> Html Msg
clickerDiv (c, q, m) =
  div []
      [ text ((toString c) ++ " | Q: " ++ (toString q) ++ " M: " ++ (toString m))
      , br [] []
      , button [] [text "Buy"]
      , br [] []
      , br [] []
      ]
