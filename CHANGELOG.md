# Changelog

## 1.0.1

### Fixed

- `XMLFirstCase` returned its match wrapped in `Sequence`, so `v = XMLFirstCase[...]` assigned `Sequence[match]` to `v`. It now returns the match without the wrapper (#86).
- `XMLExtract[tree, {}]` returned the whole tree, so `XMLExtract[tree, XMLPosition[tree, pattern]]` returned the tree when `pattern` had no matches. `XMLExtract` now treats `{}` as a list of zero positions, as `Extract` does, and returns `{}`. `XMLExtract[tree, {{}}]` returns the document (#71).
- `XMLFreeQ` and `XMLMatchQ` matched an `XMLDocument` pattern only against an `XMLObject`, whereas `XMLCases` also matches it against a list or a bare `XMLElement`: `XMLFreeQ[{p}, XMLDocument[{XMLPattern["p"]}]]` returned `True` and `XMLMatchQ[{p}, XMLDocument[]]` returned `False`. All three functions now treat every input as having a document at depth 0, as specified in ADR 0018 (#74).

## 1.0.0

First public release.
