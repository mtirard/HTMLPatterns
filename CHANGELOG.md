# Changelog

## Unreleased

### Fixed

- `XMLFirstCase` gave its match wrapped in `Sequence`, which `Set` and `Rule` kept: `v = XMLFirstCase[...]` stored `Sequence[match]`. It now gives the match itself (#86).
- `XMLExtract[tree, {}]` gave the whole tree, so `XMLExtract[tree, XMLPosition[tree, pattern]]` gave the tree when nothing matched. `{}` is now a list of no positions, as in `Extract`, and gives `{}`. Extract the document with `XMLExtract[tree, {{}}]` (#71).

## 1.0.0

First public release.
