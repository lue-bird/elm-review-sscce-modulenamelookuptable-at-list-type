module Sscce.ModuleNameLookupTableAtListTypeTest exposing (all)

import Review.Test
import Sscce.ModuleNameLookupTableAtListType
import Test exposing (Test)


all : Test
all =
    Test.describe "Sscce.ModuleNameLookupTableAtListType"
        [ Test.test "type List origin should be \"\"" <|
            \() ->
                """module A exposing (..)
type alias Ints =
    List Int
"""
                    |> Review.Test.run Sscce.ModuleNameLookupTableAtListType.rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = ""
                            , details = [ "message is the origin of the aliased type according to lookup" ]
                            , under = "List Int"
                            }
                        ]
        ]
