# Changelog

All notable changes to this project will be documented in this file.

This project uses semantic versioning for public releases.

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
