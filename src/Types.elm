module Types exposing (..)

import Html5.DragDrop as DragDrop


type alias Sound =
    String


type alias Position =
    Int


type alias Model =
    { dragDrop : DragDrop.Model Position Position
    , currentSound : Maybe Position
    , nextSound : Maybe Position
    , sounds : List Sound
    }



{-
   Need to detect end of previous sound in order to move to next
   => JS event?
-}


type Msg
    = DragDropMsg (DragDrop.Msg Position Position)
    | AddSound Position
    | Insert Position Sound
    | CurrentSoundFinished
    | PlayNextSound
    | SetNextSound Position
    | Save
