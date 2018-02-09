module Clickers exposing (..)

import List exposing (map)

type Clicker =
  Macro
  | BashScript
  | UndergradStudent
  | GradStudent
  | Professor
  | ResearchTeam
  | AGI

type alias ClickerData = (Clicker, Int, Float)

list = [
  Macro
  , BashScript
  , UndergradStudent
  , GradStudent
  , Professor
  , ResearchTeam
  , AGI
  ]

init : List ClickerData
init = map (\c -> (c, 0, 1.0)) list

{-| Returns the friendly name of a Clicker.
Either in the plural (True) or singular (False) form
depending on the passed Bool
-}
name : Clicker -> Bool -> String
name clicker plural =
  let
    s = case clicker of
          Macro ->
            "Macro"
          BashScript ->
            "Bash Script"
          UndergradStudent ->
            "Undergrad Student"
          GradStudent ->
            "Grad Student"
          Professor ->
            "Professor"
          ResearchTeam ->
            "Research Team"
          AGI ->
            "Artificial General Intelligence"
  in
    s ++ if plural then "s" else ""

{-| Returns the purchase cost of a Clicker, given
that some quantity has already been purchased
-}
cost : Clicker -> Int -> Int
cost clicker amt =
  let
    defaultInc = \c n -> c + (c*n)//20
  in
    case clicker of
      Macro ->
        defaultInc 50 amt
      BashScript ->
        defaultInc 500 amt
      UndergradStudent ->
        defaultInc 3000 amt
      GradStudent ->
        defaultInc 20000 amt
      Professor ->
        defaultInc 200000 amt
      ResearchTeam ->
        defaultInc 5000000 amt
      AGI ->
        defaultInc 1010011010 amt

{-| Returns the base loc earnings per second for a Clicker
-}
earnings : Clicker -> Float
earnings clicker = case clicker of
  Macro ->
    0.5
  BashScript ->
    8.0
  UndergradStudent ->
    30.0
  GradStudent ->
    80.0
  Professor ->
    200.0
  ResearchTeam ->
    4000.0
  AGI ->
    1048576.0
