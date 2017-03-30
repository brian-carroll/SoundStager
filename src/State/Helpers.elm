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


   Potential improvement
        Implement tail recursion to avoid stack overflow
        Iterate to stopPos then return full result
        result =
            if dragPos > dropPos then
                before ++ between ++ dropItem ++ after
            else
                before ++ dropItem ++ between ++ after
        Append to different lists depending on where we are
            before drag and drop
                tail recursion, appending to before
            at drag
                tail recursion, with [dragItem]
            between drag and drop
                tail recursion, appending to between
            after stopPos
                return result
        Avoid mistakes
            Write out return expression in each test case
                moveItem 1 4 [ "0", "1", "2", "3", "4" ]
                    = ["0"] ++ ["2", "3"] ++ ["1"] ++ ["4"]
                moveItem 3 1 [ "0", "1", "2", "3", "4" ]
                    = ["0"] ++ ["3"] ++ ["1", "2"] ++ ["4"]
                moveItem 3 0 [ "0", "1", "2", "3", "4" ]
                    = [] ++ ["3"] ++ ["0", "1", "2"] ++ ["4"]
                moveItem 2 5 [ "0", "1", "2", "3", "4" ]
                    = ["0", "1"] ++ ["3", "4"] ++ ["2"] ++ []
        Closure around max and min => avoid lots of args but get lots of indentation
-}


moveItem : Int -> Int -> List a -> List a
moveItem dragPos dropPos list =
    let
        pos1 =
            min dragPos dropPos

        pos2 =
            max dragPos dropPos

        betweenFirst =
            if dropPos > dragPos then
                dragPos + 1
            else
                dropPos

        betweenLast =
            if dropPos > dragPos then
                dropPos - 1
            else
                dragPos - 1

        moveItemHelp : List a -> List a -> List a -> Int -> List a -> List a
        moveItemHelp dragItemList before between pos list =
            let
                h =
                    List.take 1 list

                t =
                    List.drop 1 list
            in
                if pos < pos1 then
                    moveItemHelp dragItemList (before ++ h) between (pos + 1) t
                else if pos == dragPos then
                    moveItemHelp h before between (pos + 1) t
                else if (pos >= betweenFirst) && (pos <= betweenLast) then
                    moveItemHelp dragItemList before (between ++ h) (pos + 1) t
                else if dragPos > dropPos then
                    before ++ dragItemList ++ between ++ list
                else
                    before ++ between ++ dragItemList ++ list
    in
        moveItemHelp [] [] [] 0 list



--moveItemHelp


moveItemHelpOld : Int -> Int -> Int -> Int -> Maybe a -> List a -> ( Maybe a, List a )
moveItemHelpOld dragPos dropPos stopPos pos inputDragItem list =
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
                    moveItemHelpOld dragPos dropPos stopPos (pos + 1) dragItem (List.drop 1 list)

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
