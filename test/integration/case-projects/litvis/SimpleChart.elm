module SimpleChart exposing (..)
import Json.Encode
-------- literate-elm code 0
import VegaLite exposing (..)
-------- literate-elm code 1
barChart : Spec
barChart =
    let
        cars =
            dataFromUrl "https://vega.github.io/vega-lite/data/cars.json" []

        enc =
            encoding
                << position X [ pName "Horsepower", pMType Quantitative ]
                << position Y [ pName "Miles_per_Gallon", pMType Quantitative ]
                << color [ mName "Origin", mMType Nominal ]
    in
    toVegaLite [ cars, circle [], enc [] ]
-------- literate-elm output
literateElmOutputSymbol : String
literateElmOutputSymbol =
    Json.Encode.encode 0 <|
        Json.Encode.object
            [
-------- literate-elm output expression barChart
          ("barChart", Json.Encode.string <| Debug.toString <| barChart)
-------- literate-elm output end
            ]