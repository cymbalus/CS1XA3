module View exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (disabled)
import Models exposing (Model)
import Msgs exposing (Msg)
import Shop
import Clickers
import Types exposing (..)

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
            (List.map (clickerDiv model) model.clickers)
      ]

clickerDiv : Model -> ClickerData -> Html Msg
clickerDiv model (c, q, m) =
  div []
      [ text ((toString c) ++ " |#| Cost: " ++ (toString (Clickers.cost c q)) ++ " Q: " ++ (toString q) ++ " M: " ++ (toString m))
      , br [] []
      , button [ disabled (not (Shop.canAfford model (ClickerItem c)))
               , onClick (Msgs.Purchase (ClickerItem c)) ]
               [ text "Buy" ]
      , br [] []
      , br [] []
      ]
