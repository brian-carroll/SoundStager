module State.Helpers exposing (..)


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
        insertAt insertPos dragDropItem removed


insertAt : Int -> List a -> List a -> List a
insertAt pos newItems list =
    (List.take pos list)
        ++ newItems
        ++ (List.drop pos list)
