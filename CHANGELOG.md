# Changelog

All notable changes to this project will be documented in this file.

This project uses semantic versioning for public releases.

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
