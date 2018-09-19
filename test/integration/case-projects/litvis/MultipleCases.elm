module MultipleCases exposing (..)
import Json.Encode
-------- literate-elm code 0

-- PRIMITIVES


intTest : Int
intTest =
    3 + 4 // 2


floatTest : Float
floatTest =
    3 + 4 / 2


boolTest : Bool
boolTest =
    True


stringTest : String
stringTest =
    "Hello world!"


stringTestWithSymbols : String
stringTestWithSymbols =
    "Can we handle {} [] \" `` \\ ()? And a \n new line?"



-- LISTS OF PRIMITIVES


intListTest : List Int
intListTest =
    List.range 1 10


floatListTest : List Float
floatListTest =
    List.range 1 10 |> List.map (\n -> toFloat n / 2)


boolListTest : List Bool
boolListTest =
    List.range 1 10 |> List.map (\n -> modBy 2 n == 0)


stringListTest : List String
stringListTest =
    [ "John", "Paul", "George", "Ringo" ]



-- NESTED LISTS OF PRIMITIVES


nestedIntTest : List (List Int)
nestedIntTest =
    [ intListTest, [], intListTest ]


nestedFloatTest : List (List Float)
nestedFloatTest =
    [ floatListTest, [], floatListTest ]


nestedBoolTest : List (List Bool)
nestedBoolTest =
    [ boolListTest, [], boolListTest ]


nestedStringTest : List (List String)
nestedStringTest =
    [ stringListTest, [], [ "" ], stringListTest |> List.reverse ]



-- TUPLES


tupleTest : ( String, Int )
tupleTest =
    ( "Hastings", 1066 )


tupleListTest : List ( String, Int )
tupleListTest =
    List.repeat 4 tupleTest



-- RECORDS


recordTest : { battle : String, date : Int }
recordTest =
    { battle = "Hastings", date = 1066 }


type alias Battle =
    { battle : String, date : Int }


recordTestWithAlias : Battle
recordTestWithAlias =
    { battle = "Hastings", date = 1066 }



-- PARTIALLY APPLIED FUNCTIONS


add : Int -> Int -> Int
add a b =
    a + b


add6 : Int -> Int
add6 =
    add 6


add6And8 : Int
add6And8 =
    add6 8

-------- literate-elm output
literateElmOutputSymbol : String
literateElmOutputSymbol =
    Json.Encode.encode 0 <|
        Json.Encode.object
            [
-------- literate-elm output expression intTest
          ("intTest", Json.Encode.string <| Debug.toString <| intTest),
-------- literate-elm output expression floatTest
          ("floatTest", Json.Encode.string <| Debug.toString <| floatTest),
-------- literate-elm output expression boolTest
          ("boolTest", Json.Encode.string <| Debug.toString <| boolTest),
-------- literate-elm output expression stringTest
          ("stringTest", Json.Encode.string <| Debug.toString <| stringTest),
-------- literate-elm output expression stringTestWithSymbols
          ("stringTestWithSymbols", Json.Encode.string <| Debug.toString <| stringTestWithSymbols),
-------- literate-elm output expression intListTest
          ("intListTest", Json.Encode.string <| Debug.toString <| intListTest),
-------- literate-elm output expression floatListTest
          ("floatListTest", Json.Encode.string <| Debug.toString <| floatListTest),
-------- literate-elm output expression boolListTest
          ("boolListTest", Json.Encode.string <| Debug.toString <| boolListTest),
-------- literate-elm output expression stringListTest
          ("stringListTest", Json.Encode.string <| Debug.toString <| stringListTest),
-------- literate-elm output expression nestedIntTest
          ("nestedIntTest", Json.Encode.string <| Debug.toString <| nestedIntTest),
-------- literate-elm output expression nestedFloatTest
          ("nestedFloatTest", Json.Encode.string <| Debug.toString <| nestedFloatTest),
-------- literate-elm output expression nestedBoolTest
          ("nestedBoolTest", Json.Encode.string <| Debug.toString <| nestedBoolTest),
-------- literate-elm output expression nestedStringTest
          ("nestedStringTest", Json.Encode.string <| Debug.toString <| nestedStringTest),
-------- literate-elm output expression tupleTest
          ("tupleTest", Json.Encode.string <| Debug.toString <| tupleTest),
-------- literate-elm output expression tupleListTest
          ("tupleListTest", Json.Encode.string <| Debug.toString <| tupleListTest),
-------- literate-elm output expression recordTest
          ("recordTest", Json.Encode.string <| Debug.toString <| recordTest),
-------- literate-elm output expression recordTestWithAlias
          ("recordTestWithAlias", Json.Encode.string <| Debug.toString <| recordTestWithAlias),
-------- literate-elm output expression add
          ("add", Json.Encode.string <| Debug.toString <| add),
-------- literate-elm output expression add6
          ("add6", Json.Encode.string <| Debug.toString <| add6),
-------- literate-elm output expression add6And8
          ("add6And8", Json.Encode.string <| Debug.toString <| add6And8)
-------- literate-elm output end
            ]

