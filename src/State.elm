module State exposing (init, update, subscriptions)

import Types exposing (..)
import Html5.DragDrop as DragDrop


init : ( Model, Cmd Msg )
init =
    { dragDrop = DragDrop.init
    , currentSound = Just 0
    , nextSound = Just 1
    , sounds =
        [ "crash.mp3"
        , "bang.mp3"
        , "wallop.mp3"
        , "meow.mp3"
        , "woof.mp3"
        , "neigh.mp3"
        ]
    }
        ! []


subscriptions : a -> Sub Msg
subscriptions =
    (\_ -> Sub.none)


moveItem : Int -> Int -> List a -> List a
moveItem dragPos dropPos list =
    let
        before =
            (List.take dragPos list)

        rest =
            (List.drop dragPos list)

        after =
            List.drop 1 rest

        removed =
            before ++ after

        dragDropItem =
            List.take 1 rest

        insertPos =
            if dragPos < dropPos then
                dropPos - 1
            else
                dropPos
    in
        (List.take insertPos removed)
            ++ dragDropItem
            ++ (List.drop insertPos removed)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DragDropMsg ddMsg ->
            let
                ( ddModel, maybeDragDropPosTuple ) =
                    DragDrop.updateSticky ddMsg model.dragDrop

                updatedSounds =
                    case maybeDragDropPosTuple of
                        Nothing ->
                            model.sounds

                        Just ( dragPos, dropPos ) ->
                            moveItem dragPos dropPos model.sounds
            in
                { model
                    | dragDrop = ddModel
                    , sounds = updatedSounds
                }
                    ! []

        _ ->
            ( model, Cmd.none )
