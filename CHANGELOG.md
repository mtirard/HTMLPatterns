# Changelog

## Unreleased

### Fixed

- `XMLFirstCase` gave its match wrapped in `Sequence`, which `Set` and `Rule` kept: `v = XMLFirstCase[...]` stored `Sequence[match]`. It now gives the match itself (#86).

## 1.0.0

First public release.
