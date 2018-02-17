module View exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Time exposing (Time, second)
import Models exposing (Model)
import Msgs exposing (Msg)
import Shop
import Clickers
import Types exposing (..)
import Styles exposing (..)

import FormatNumber exposing (format)
import FormatNumber.Locales exposing (usLocale)

import Bootstrap.Grid as Grid
import Bootstrap.Grid.Row as Row
import Bootstrap.Grid.Col as Col
import Bootstrap.Accordion as Accordion
import Bootstrap.Card as Card


{-
Temporary view for testing purposes
-}


view : Model -> Html Msg
view model =
  div [style [("margin", "0px"), ("padding", "0px")]]
      [ Grid.container [style gridContainer]
        [ Grid.row [Row.attrs [style [("margin", "0px"), ("padding", "0px")]]]
            [ Grid.col [Col.xs2, Col.attrs [style sideCol]]
                [ clickerTitle
                , clickerAccordion model
                ]
            , Grid.col [Col.xs8, Col.attrs [style gridCol]] [ centerDiv model ]
            , Grid.col [Col.xs2, Col.attrs [style sideCol]] [ text "One of Three columns" ]
            ]
        ]
      , earningsPanel model
      ]

centerDiv : Model -> Html Msg
centerDiv model =
  div []
      [ p [style locRateText] [text ((format usLocale (Models.totalEarnings model second)) ++ " LoC/s")]
      , img [src "img/curtis-idle.png", style curtisImg, onClick Msgs.Click] []
      ]

earningsPanel : Model -> Html Msg
earningsPanel model =
  div [style earningPanelDiv]
      [ Grid.container [style gridContainer]
        [ Grid.row [Row.centerXs, Row.attrs [style [("margin", "0px"), ("padding", "0px")]]]
            (List.map (earningCol model) (Models.formattedEarnings model))
        ]
      ]

earningCol : Model -> (String, String, Int, String) -> Grid.Column Msg
earningCol model (title, titles, amt, image) =
  Grid.col [Col.xs1, Col.attrs [style earningColumn]]
    [ div []
        [ img [src ("img/earning_icons/" ++ image ++ ".png"), width 50, height 50, style earningIcon] []
        , div []
            [p [style earningText] [text (toString (amt))]]
        ]
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

clickerTitle : Html Msg
clickerTitle =
  div [style sideTitleDiv]
      [ p [style sideTitleText] [text "Auto Clickers"]
      ]

clickerAccordion : Model -> Html Msg
clickerAccordion model =
    Accordion.config Msgs.ClickerAccordion
      |> Accordion.withAnimation
      |> Accordion.cards
        (List.map (clickerCard model) model.clickers)
      |> Accordion.view model.gui.clickerAccordion

clickerCard : Model -> ClickerData -> Accordion.Card Msg
clickerCard model (c, q, m) =
  Accordion.card
    { id = Clickers.name c False
    , options = [Card.attrs [style card]]
    , header =
        Accordion.header [style cardHeader] <| Accordion.toggle []
          [ text (Clickers.name c False)
          , span [style [("float", "right")]]
              [ text (toString q) ]
          ]
    , blocks =
        [ Accordion.block []
            [ Card.text []
              [ button [ disabled (not (Shop.canAfford model (ClickerItem c)))
                       , onClick (Msgs.Purchase (ClickerItem c)) ]
                       [ text "Buy" ]
              ]
            ]
        ]
    }
