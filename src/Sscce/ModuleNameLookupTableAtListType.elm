module Sscce.ModuleNameLookupTableAtListType exposing (rule)

import Elm.Syntax.Declaration
import Elm.Syntax.Node
import Elm.Syntax.Range
import Review.ModuleNameLookupTable
import Review.Rule


rule : Review.Rule.Rule
rule =
    Review.Rule.newModuleRuleSchemaUsingContextCreator "Sscce.ModuleNameLookupTableAtListType"
        (Review.Rule.initContextCreator
            (\originLookup () ->
                { originLookup = originLookup }
            )
            |> Review.Rule.withModuleNameLookupTable
        )
        |> Review.Rule.withDeclarationEnterVisitor
            (\declarationNode context ->
                ( case declarationNode of
                    Elm.Syntax.Node.Node _ (Elm.Syntax.Declaration.AliasDeclaration typeAliasDeclaration) ->
                        let
                            aliasedTypeRange : Elm.Syntax.Range.Range
                            aliasedTypeRange =
                                typeAliasDeclaration.typeAnnotation |> Elm.Syntax.Node.range
                        in
                        case Review.ModuleNameLookupTable.moduleNameAt context.originLookup aliasedTypeRange of
                            Nothing ->
                                []

                            Just moduleOrigin ->
                                [ Review.Rule.error
                                    { message = moduleOrigin |> String.join "."
                                    , details = [ "message is the origin of the aliased type according to lookup" ]
                                    }
                                    aliasedTypeRange
                                ]

                    _ ->
                        []
                , context
                )
            )
        |> Review.Rule.fromModuleRuleSchema
