module NullInObject exposing (..)
import Json.Encode
-------- literate-elm code 0
import VegaLite exposing (..)
-------- literate-elm code 1
fig1 : Spec
fig1 =
    toVegaLite [ config, layer [ geoMap 300 ] ]
-------- literate-elm code 2
fig2 : Spec
fig2 =
    toVegaLite [ config, layer [ gridMapSpec 300 FixedOpacity ] ]
-------- literate-elm code 3
gridmapCrimes : Spec
gridmapCrimes =
    let
        crimeData =
            dataFromUrl "https://gicentre.github.io/data/westMidlands/westMidsCrimesShort.tsv" []

        crimeTrans =
            transform
                << filter (fiExpr "datum.month == '2016-06'")
                << filter (fiExpr "abs(datum.runs) >= 7")
                << calculateAs "11 - datum.gridY" "gridN"
                << calculateAs "datum.gridX - 1" "gridE"
                << calculateAs "datum.zScore < 0 ? 'low' : 'high'" "crimeCats"

        res =
            resolve << resolution (reScale [ ( chColor, reIndependent ) ])

        w =
            220
    in
    toVegaLite
        [ config
        , crimeData
        , crimeTrans []
        , facet [ rowBy [ fName "crimeType", fMType Ordinal, fHeader [ hdTitle "" ] ] ]
        , specification (asSpec [ res [], layer [ gridMapSpec w UserOpacity, crimeOverlay w ] ])
        ]
-------- literate-elm code 4
geoMap : Float -> Spec
geoMap w =
    asSpec
        [ width w
        , height (w / 1.54)
        , dataFromUrl "https://gicentre.github.io/data/westMidlands/westMidsTopo.json" [ topojsonFeature "NPU" ]
        , geoshape [ maStroke "white", maStrokeWidth (w * 0.00214) ]
        , encoding (color [ mName "id", mMType Nominal, mScale npuColours, mLegend [] ] [])
        ]


gridMapSpec : Float -> OpacityVal -> Spec
gridMapSpec w op =
    let
        gSize =
            w / 26

        gridData =
            dataFromUrl "https://gicentre.github.io/data/westMidlands/westMidsGridmapOpacity.tsv" []

        gridTrans =
            case op of
                FixedOpacity ->
                    transform
                        << filter (fiExpr "datum.opacity == 100")
                        << calculateAs "11 - datum.gridY" "gridN"
                        << calculateAs "datum.gridX - 1" "gridE"

                UserOpacity ->
                    transform
                        << filter (fiSelection "userOpacity")
                        << calculateAs "11 - datum.gridY" "gridN"
                        << calculateAs "datum.gridX - 1" "gridE"

        gridEnc =
            encoding
                << position X [ pName "gridE", pMType Quantitative, pAxis [] ]
                << position Y [ pName "gridN", pMType Quantitative, pAxis [] ]
                << color [ mName "NPU", mMType Nominal, mScale npuColours, mLegend [] ]
                << size [ mNum ((gSize - 1) * (gSize - 1)) ]

        gridSel =
            selection
                << select "userOpacity"
                    seSingle
                    [ seFields [ "opacity" ]
                    , seBind [ iRange "opacity" [ inName "Opacity ", inMin 0, inMax 100, inStep 10 ] ]
                    , seEmpty
                    ]
    in
    case op of
        FixedOpacity ->
            asSpec
                [ width w
                , height (w / 2.36)
                , gridData
                , gridTrans []
                , (gridEnc << opacity [ mNum 1 ]) []
                , square []
                ]

        UserOpacity ->
            asSpec
                [ width w
                , height (w / 2.36)
                , gridData
                , gridTrans []
                , gridSel []
                , (gridEnc
                    << opacity
                        [ mName "opacity"
                        , mMType Quantitative
                        , mScale [ scDomain (doNums [ 40, 100 ]) ]
                        , mLegend []
                        ]
                    )
                    []
                , square []
                ]


crimeOverlay : Float -> Spec
crimeOverlay w =
    let
        crimeEnc =
            encoding
                << position X [ pName "gridE", pMType Quantitative, pAxis [] ]
                << position Y [ pName "gridN", pMType Quantitative, pAxis [] ]
                << shape [ mName "crimeCats", mMType Nominal, mScale crimeSymbols, mLegend [] ]
                << color [ mName "crimeCats", mMType Nominal, mScale crimeColours, mLegend [] ]
                << opacity [ mNum 1 ]
                << size [ mNum (w / 3) ]
    in
    asSpec [ width w, height (w / 2.36), crimeEnc [], point [ maFilled True ] ]


type OpacityVal
    = FixedOpacity
    | UserOpacity


npuColours : List ScaleProperty
npuColours =
    categoricalDomainMap
        [ ( "Birmingham East", "#197F8E" )
        , ( "Birmingham West", "#A11F43" )
        , ( "Coventry", "#02B395" )
        , ( "Dudley", "#94C607" )
        , ( "Sandwell", "#18324A" )
        , ( "Solihull", "#FF6528" )
        , ( "Walsall", "#DC102F" )
        , ( "Wolverhampton", "#FFBA01" )
        ]


crimeSymbols =
    categoricalDomainMap
        [ ( "high", "triangle-up" )
        , ( "low", "triangle-down" )
        ]


crimeColours : List ScaleProperty
crimeColours =
    categoricalDomainMap
        [ ( "high", "rgb(202,0,32)" )
        , ( "low", "rgb(5,113,176)" )
        ]


config =
    configure (configuration (coView [ vicoStroke Nothing ]) [])
-------- literate-elm output
literateElmOutputSymbol : String
literateElmOutputSymbol =
    Json.Encode.encode 0 <|
        Json.Encode.object
            [
-------- literate-elm output expression fig1
          ("fig1", Json.Encode.string <| Debug.toString <| fig1)
-------- literate-elm output expression fig2
        , ("fig2", Json.Encode.string <| Debug.toString <| fig2)
-------- literate-elm output expression gridmapCrimes
        , ("gridmapCrimes", Json.Encode.string <| Debug.toString <| gridmapCrimes)
-------- literate-elm output end
            ]
