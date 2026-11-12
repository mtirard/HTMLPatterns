# Changelog

## Unreleased

### Fixed

- `XMLFirstCase` gave its match wrapped in `Sequence`, which `Set` and `Rule` kept: `v = XMLFirstCase[...]` stored `Sequence[match]`. It now gives the match itself (#86).
- `XMLExtract[tree, {}]` gave the whole tree, so `XMLExtract[tree, XMLPosition[tree, pattern]]` gave the tree when nothing matched. `{}` is now a list of no positions, as in `Extract`, and gives `{}`. Extract the document with `XMLExtract[tree, {{}}]` (#71).
- `XMLFreeQ` and `XMLMatchQ` found an `XMLDocument` pattern only on an `XMLObject`, though `XMLCases` finds it above a list or a bare `XMLElement` too: `XMLFreeQ[{p}, XMLDocument[{XMLPattern["p"]}]]` gave `True` and `XMLMatchQ[{p}, XMLDocument[]]` gave `False`. Every input now has a document at depth 0, as ADR 0018 has it (#74).

## 1.0.0

First public release.
