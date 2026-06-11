# Changelog

All notable changes to this project will be documented in this file.

This project uses semantic versioning for public releases.

## 0.2.14 - 2026-06-11

### Fixed

- Accepted additional valid ToastStunt syntax found in ToastCore, including
  `pass` as a local binding, scientific-notation floats, bitwise operators,
  bit shifts, unary bitwise complement, and `try` statements with either one or
  more `except` handlers or a `finally` handler.

## 0.2.13 - 2026-06-11

### Fixed

- Accepted valid ToastCore syntax for labeled `break` and `continue`
  statements, exponentiation with `^`, system-object assignment targets,
  uppercase assignment-target identifiers that collide with type constants,
  and spliced `pass` arguments in dynamic verb calls.

## 0.2.12 - 2026-06-10

### Added

- Exposed durable MOO string-literal comment statements as named `comment`
  nodes and added comment highlighting.
- Added a `dynamic_verb_selector` node so static and computed verb selectors
  are distinguishable in downstream code-fact extraction.
- Added syntax-fact queries for calls, function calls, object references,
  system objects, property access, assignments, and comments.
- Added corpus coverage for code-fact extraction surfaces.

## 0.2.11 - 2026-06-09

### Fixed

- Wrote the Wasm smoke test's Tree-sitter config with an absolute parser
  directory so Docker-backed Emscripten builds can mount the grammar correctly
  in GitHub Actions.

## 0.2.10 - 2026-06-09

### Added

- Added a layered PR test suite with focused corpus tests, query validation,
  fixture validation, generated-source checks, and binding smoke tests.
- Added sample MOO parsing smoke coverage for Node, Go, Rust, Python, C, and
  Wasm. Swift remains declared but documented as not CI-verified.
- Added `TESTING.md`, `docs/USAGE.md`, `docs/EDITORS.md`, and
  `docs/BINDINGS.md` to keep README focused while documenting usage, editor
  setup, binding examples, and test tiers.

### Changed

- Standardized fixture validation docs on `npm run test:fixtures`.
- Aligned Rust, Python, and Go binding metadata with the public
  `SindomeCorp/tree-sitter-moo` repository and the 0.25 Tree-sitter runtime
  requirement.
- Moved inline package-script logic into dedicated scripts under `scripts/`.

## 0.2.9 - 2026-06-09

### Fixed

- Kept the npm publish job on Node 22 while installing npm 11.15 for trusted
  publishing, avoiding a Node 24 native build failure in the Tree-sitter
  runtime dependency.

## 0.2.8 - 2026-06-09

### Changed

- Switched the npm release workflow from token publishing to npm trusted
  publishing through GitHub Actions OIDC.
- Updated package documentation to lead with npm installation for normal
  consumers.

## 0.2.7 - 2026-06-09

### Fixed

- Declared the native Node binding's Tree-sitter 0.25 runtime requirement for
  the generated ABI 15 parser and expanded the smoke test to exercise
  `Parser.setLanguage`.
- Committed regenerated parser metadata for the release version.

## 0.2.6 - 2026-06-09

### Fixed

- Superseded by 0.2.7 after release validation found stale generated parser
  metadata.

## 0.2.5 - 2026-06-09

### Fixed

- Downloaded native prebuild artifacts into the `prebuilds/` package directory
  before publishing and verified all five native prebuilds are present.

## 0.2.4 - 2026-06-09

### Fixed

- Stopped requiring the Wasm binary to be byte-for-byte identical after the
  release validation build. The release workflow still validates and packages a
  freshly built Wasm artifact.

## 0.2.3 - 2026-06-08

### Fixed

- Updated the macOS x64 release runner from deprecated `macos-13` to the
  current Intel runner label, `macos-15-intel`.

## 0.2.2 - 2026-06-08

### Fixed

- Removed the unnecessary Wasm build from native prebuild jobs so macOS release
  runners do not require `emcc`, Docker, or Podman.

## 0.2.1 - 2026-06-08

### Added

- npm release workflow that publishes only from `v*` tags.
- Native prebuild release targets for Linux x64, Linux arm64, macOS x64,
  macOS arm64, and Windows x64.
- Package smoke tests for native bindings and Wasm artifacts.
- Release documentation covering first publish, trusted publishing, and normal
  release steps.

### Changed

- Added package metadata for the public npm release.
- Included project documentation files in the npm package.

## 0.2.0 - 2026-06-08

### Added

- Browser-loadable `dist/tree-sitter-moo.wasm` package artifact.
- `tree-sitter-moo/wasm` package export for downstream web editors.
- Query file package exports for highlights and tags.
- `tree-sitter.json` parser metadata for current Tree-sitter CLI tooling.
- Public GitHub install documentation for downstream development consumers.

### Changed

- Updated CI to run the full package workflow, including Wasm generation and
  `npm pack --dry-run`.
- Updated generated parser artifacts with `tree-sitter-cli` 0.25.

## 0.1.0 - 2026-06-08

Initial public release.

### Added

- Tree-sitter grammar for raw MOO verb bodies.
- ToastStunt-first syntax coverage while preserving LambdaMOO-compatible forms.
- Support for assignments, assignment expressions, scatter assignment, list
  splicing, conditionals, loops, `try`/`except`, `fork`, calls, property access,
  inline error-catching expressions, list/range syntax, and ToastStunt maps.
- Generated parser and bindings for common Tree-sitter package targets.
- Neovim query files and setup documentation.
- Helix and Emacs setup notes.
- 446 valid MOO fixtures imported from
  [`moo-for-llms`](https://github.com/SindomeCorp/moo-for-llms).
- Strict fixture validator that fails on `ERROR` or `MISSING` parse nodes.
- GitHub Actions CI.

### Known Gaps

- LambdaMOO strict dialect mode is not implemented yet.
- Zed and VS Code extensions are not included yet.
- Tags, locals, and indentation queries are minimal.
