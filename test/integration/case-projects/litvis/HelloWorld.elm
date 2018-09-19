module HelloWorld exposing (..)
import Json.Encode
-------- literate-elm code 0
message : String
message =
    "Hello world!!!"

-------- literate-elm output
literateElmOutputSymbol : String
literateElmOutputSymbol =
    Json.Encode.encode 0 <|
        Json.Encode.object
            [
-------- literate-elm output expression message
          ("message", Json.Encode.string <| Debug.toString <| message)
-------- literate-elm output end
            ]

