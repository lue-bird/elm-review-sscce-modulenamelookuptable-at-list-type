## elm-review-sscce-modulenamelookuptable-at-list-type

Demonstrates that [`Review.ModuleNameLookupTable.moduleNameAt`](https://dark.elm.dmy.fr/packages/jfmengels/elm-review/latest/Review-ModuleNameLookupTable#moduleNameAt)
returns `[ "List" ]` for a `List` type,
even though the `List` module does not expose that type.

Reported in https://github.com/jfmengels/elm-review/issues/173
