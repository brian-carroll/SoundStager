module State.Helpers exposing (moveItem, maybeToList, insertAt)

{-| moveItem
   Drag-and-drop operation on a list, in just one recursive pass

   iterate down the list
   on the way down
        pick up the dragged item from dragPos
        keep going till max(dragPos, dropPos)
        dragged item needs to be passed down (arg) AND back up (return val)

   on the way back up, insert it at dropPos
     glue each item back onto the result list
     unless
         we're at dragPos, in which case do nothing
         or we're at dropPos, in which case insert 2 items instead of 1
-}


moveItem : Int -> Int -> List a -> List a
moveItem dragPos dropPos list =
    let
        stopPos =
            max dragPos dropPos

        ( _, newList ) =
            moveItemHelp dragPos dropPos stopPos 0 Nothing list
    in
        newList


moveItemHelp : Int -> Int -> Int -> Int -> Maybe a -> List a -> ( Maybe a, List a )
moveItemHelp dragPos dropPos stopPos pos inputDragItem list =
    let
        dragItem =
            if pos == dragPos then
                List.head list
            else
                inputDragItem
    in
        if pos > stopPos then
            ( dragItem, list )
        else
            let
                ( dropItem, result ) =
                    moveItemHelp dragPos dropPos stopPos (pos + 1) dragItem (List.drop 1 list)

                first =
                    List.take 1 list
            in
                case ( pos == dragPos, pos == dropPos ) of
                    ( True, False ) ->
                        ( dropItem, result )

                    ( False, True ) ->
                        ( dropItem
                        , (maybeToList dropItem) ++ first ++ result
                        )

                    _ ->
                        ( dropItem, first ++ result )


maybeToList : Maybe a -> List a
maybeToList x =
    case x of
        Nothing ->
            []

        Just x ->
            [ x ]


insertAt : Int -> List a -> List a -> List a
insertAt pos newItems list =
    (List.take pos list)
        ++ newItems
        ++ (List.drop pos list)
