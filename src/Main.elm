module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


main : Html.Html msg
main =
    div []
        [ text "Hello, world"
        , br [] []
        , input [ type_ "file" ] []
        , audio [ src "sounds/doorbell.mp3", controls True ] []
        ]
