module View exposing (root)

import Html exposing (..)
import Html.Attributes exposing (..)


soundFileNames : List String
soundFileNames =
    [ "crash.mp3"
    , "bang.mp3"
    , "wallop.mp3"
    , "meow.mp3"
    , "woof.mp3"
    , "neigh.mp3"
    ]


root : Html msg
root =
    div []
        [ text "Hello, world"
        , br [] []
        , input [ type_ "file" ] []
        , audio [ src "sounds/doorbell.mp3", controls True ] []
        , hr [] []
        , (soundList soundFileNames)
        ]


soundList : List String -> Html msg
soundList fileNames =
    table
        [ style
            [ ( "text-align", "center" )
            , ( "max-width", "300px" )
            , ( "margin", "auto" )
            ]
        ]
        (separator
            :: List.concat (List.map soundWrapper fileNames)
        )


soundWrapper : String -> List (Html msg)
soundWrapper fileName =
    [ tr []
        [ td []
            [ sound fileName ]
        ]
    , separator
    ]


separator : Html msg
separator =
    tr []
        [ td [] []
        , td []
            [ button [] [ text "+" ]
            ]
        ]


sound : String -> Html msg
sound fileName =
    div
        [ class "sound" ]
        [ text fileName ]
