module Main exposing (..)

-- External libraries

import Html


-- Local modules

import View
import State
import Types exposing (Model, Msg)


{-| Entry point for the app
-}
main : Program Never Model Msg
main =
    Html.program
        { init = State.init
        , update = State.update
        , subscriptions = State.subscriptions
        , view = View.root
        }
