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
    div
        [ style
            [ ( "text-align", "center" )
            , ( "max-width", "300px" )
            , ( "margin", "auto" )
            ]
        ]
        (separator
            :: (List.map soundWrapper fileNames)
        )


soundWrapper : String -> Html msg
soundWrapper fileName =
    div []
        [ (sound fileName)
        , separator
        ]


separator : Html msg
separator =
    div []
        [ dropZone
        , div
            [ style
                [ ( "display", "inline-block" )
                , ( "width", "20%" )
                , ( "background-color", "red" )
                  -- , ( "padding-top", "10px" )
                  -- , ( "padding-bottom", "10px" )
                ]
            ]
            [ button [] [ text "+" ]
            ]
        ]


dropZone : Html msg
dropZone =
    div
        [ style
            [ ( "padding-top", "10px" )
            , ( "padding-bottom", "10px" )
            , ( "background-color", "blue" )
            , ( "display", "inline-block" )
            , ( "width", "80%" )
            ]
        ]
        []


sound : String -> Html msg
sound fileName =
    div
        [ style
            [ ( "padding-top", "20px" )
            , ( "padding-bottom", "20px" )
            , ( "width", "80%" )
            , ( "display", "inline-block" )
            , ( "border", "1px solid black" )
            , ( "float", "left" )
            ]
        ]
        [ text fileName ]
