module State exposing (init, update, subscriptions)

-- External modules

import Html5.DragDrop as DragDrop


-- Local modules

import Types exposing (..)
import State.Helpers exposing (moveItem, insertAt)


init : ( Model, Cmd Msg )
init =
    { dragDrop = DragDrop.init
    , currentSound = Just 0
    , nextSound = Just 1
    , sounds =
        [ "0", "1", "2", "3", "4" ]
        -- [ "crash.mp3"
        -- , "bang.mp3"
        -- , "wallop.mp3"
        -- , "meow.mp3"
        -- , "woof.mp3"
        -- , "neigh.mp3"
        -- ]
    }
        ! []


subscriptions : a -> Sub Msg
subscriptions =
    (\_ -> Sub.none)


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
                ( { model
                    | dragDrop = ddModel
                    , sounds = updatedSounds
                  }
                , Cmd.none
                )

        InsertSound pos sound ->
            ( { model
                | sounds =
                    insertAt pos [ sound ] model.sounds
              }
            , Cmd.none
            )

        _ ->
            Debug.crash "State.update case not implemented"
