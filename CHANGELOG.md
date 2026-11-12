# Changelog

## 1.0.1

### Fixed

- `XMLFirstCase` returned its match wrapped in `Sequence`, so `v = XMLFirstCase[...]` assigned `Sequence[match]` to `v`. It now returns the match without the wrapper (#86).
- `XMLExtract[tree, {}]` returned the whole tree, so `XMLExtract[tree, XMLPosition[tree, pattern]]` returned the tree when `pattern` had no matches. `XMLExtract[tree, {}]` now returns `{}`: `{}` is a list of zero positions, as in `Extract`. `XMLExtract[tree, {{}}]` returns the document (#71).
- `XMLFreeQ` and `XMLMatchQ` matched an `XMLDocument` pattern only against an `XMLObject`, whereas `XMLCases` also matches it against a list or a bare `XMLElement`: `XMLFreeQ[{p}, XMLDocument[{XMLPattern["p"]}]]` returned `True` and `XMLMatchQ[{p}, XMLDocument[]]` returned `False`. `XMLFreeQ` and `XMLMatchQ` now match an `XMLDocument` pattern at depth 0 of every input, as `XMLCases` does (#74).

## 1.0.0

First public release.
