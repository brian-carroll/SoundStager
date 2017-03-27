module Tests exposing (..)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import State.Helpers exposing (moveItem)


all : Test
all =
    describe "SoundStager Test Suite"
        [ describe "Drag And Drop algorithm (moveItem)"
            [ test "Internal move, left to right" <|
                \() ->
                    Expect.equal
                        (moveItem 1 4 [ "0", "1", "2", "3", "4" ])
                        [ "0", "2", "3", "1", "4" ]
            , test "Internal move, right to left" <|
                \() ->
                    Expect.equal
                        (moveItem 3 1 [ "0", "1", "2", "3", "4" ])
                        [ "0", "3", "1", "2", "4" ]
            , test "Move to beginning" <|
                \() ->
                    Expect.equal
                        (moveItem 3 0 [ "0", "1", "2", "3", "4" ])
                        [ "3", "0", "1", "2", "4" ]
            , test "Move to end" <|
                \() ->
                    Expect.equal
                        (moveItem 2 5 [ "0", "1", "2", "3", "4" ])
                        [ "0", "1", "3", "4", "2" ]
              -- , fuzz3 int int (list string) "Preserves list length" <|
              --     \dragPos dropPos aList ->
              --         List.length (moveItem dragPos dropPos aList)
              --             |> Expect.equal (List.length aList)
              -- , fuzz3 int int (list string) "Preserves sorted values" <|
              --     \dragPos dropPos aList ->
              --         List.sort (moveItem dragPos dropPos aList)
              --             |> Expect.equal (List.sort aList)
            ]
        ]
