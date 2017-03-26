module View exposing (root)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)
import Html5.DragDrop as DragDrop


root : Model -> Html Msg
root model =
    div []
        [ text "Hello, world"
        , br [] []
        , input [ type_ "file" ] []
        , audio [ src "sounds/doorbell.mp3", controls True ] []
        , hr [] []
        , (soundList model)
        ]


soundList : Model -> Html Msg
soundList model =
    let
        -- Position at which user is about to drop dat sound
        dropPos : Maybe Position
        dropPos =
            DragDrop.getDropId model.dragDrop
    in
        table
            [ style
                [ ( "text-align", "center" )
                , ( "max-width", "300px" )
                , ( "margin", "auto" )
                ]
            ]
            ((separator 0 dropPos)
                :: List.concat (List.indexedMap (soundWrapper model dropPos) model.sounds)
            )


soundWrapper : Model -> Maybe Position -> Position -> Sound -> List (Html Msg)
soundWrapper model dropPos pos fileName =
    [ tr []
        [ td []
            [ sound pos fileName ]
        ]
    , separator (pos + 1) dropPos
    ]


separator : Position -> Maybe Position -> Html Msg
separator pos dropPos =
    let
        dropAttrs =
            if dropPos == Just pos then
                [ style [ ( "background-color", "cyan" ) ] ]
            else
                DragDrop.droppable DragDropMsg pos
    in
        tr []
            [ td dropAttrs []
            , td []
                [ button [] [ text "+" ]
                ]
            ]


sound : Position -> Sound -> Html Msg
sound pos fileName =
    let
        dragAttrs =
            DragDrop.draggable DragDropMsg pos
    in
        div
            ([ class "sound" ] ++ dragAttrs)
            [ text fileName ]
