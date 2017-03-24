module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


main : Html.Html msg
main =
    div []
        [ text "Wassup, world"
        , br [] []
        , input [ type_ "file" ] []
        , audio [ src "test-data/doorbell.mp3", controls True ] []
        ]
