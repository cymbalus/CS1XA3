module View exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Models exposing (Model)
import Msgs exposing (Msg)
import Shop
import Clickers
import Types exposing (..)
import Styles exposing (..)

import Bootstrap.Grid as Grid
import Bootstrap.Grid.Row as Row
import Bootstrap.Grid.Col as Col


{-
Temporary view for testing purposes
-}


view : Model -> Html Msg
view model =
  div []
      [ Grid.container [style gridContainer]
        [ Grid.row []
            [ Grid.col [Col.xs2, Col.attrs [style sideCol]] [ text "One of Three columns" ]
            , Grid.col [Col.xs8, Col.attrs [style gridCol]] [ centerDiv model ]
            , Grid.col [Col.xs2, Col.attrs [style sideCol]] [ text "One of Three columns" ]
            ]
        ]
      ]

centerDiv : Model -> Html Msg
centerDiv model =
  div []
      [img [src "img/curtis-idle.png", style curtisImg] []]
{-

view model =
  div []
      [ div []
          [
            h1 [] [text (toString (round model.loc_counter))]
          ]
        , button [ onClick Msgs.Click ] [ text "+" ]
        , br [] []
        , div []
            (List.map (clickerDiv model) model.clickers)
        , gridTestDiv
      ]
-}

gridTestDiv : Html Msg
gridTestDiv =
  Grid.row [ Row.centerXs ]
    [ Grid.col [ Col.xs2 ]
        [ text "Col 1" ]
    , Grid.col [ Col.xs2 ]
        [ text "Col 2" ]
    , Grid.col [ Col.xs2 ]
        [ text "Col 3" ]
    , Grid.col [ Col.xs2 ]
        [ text "Col 4" ]
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
