module MultipleCases exposing (..)
import Json.Encode
-------- literate-elm code 0

listOfInts : List Int
listOfInts =
    List.range 3 13

booleanSymbol : Bool
booleanSymbol = True

-------- literate-elm output
literateElmOutputSymbol : String
literateElmOutputSymbol =
    Json.Encode.encode 0 <|
        Json.Encode.object
            [
-------- literate-elm output expression listOfInts
          ("listOfInts", Json.Encode.string <| Debug.toString <| listOfInts),
-------- literate-elm output expression booleanSymbol
          ("booleanSymbol", Json.Encode.string <| Debug.toString <| booleanSymbol)
-------- literate-elm output end
            ]

