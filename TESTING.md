# Testing

This repository uses a layered test suite. The goal is fast local feedback for
grammar edits, plus broader smoke checks for fixtures, bindings, generated
artifacts, and release packaging.

## Prerequisites

Install Node dependencies first:

```sh
npm ci
```

The pull-request suite also runs Go, Rust, Python, C, and Wasm binding smoke
tests. Install Go and Rust locally before running the full suite:

```sh
go version
cargo --version
```

If `go` is not available, `npm run test:go` skips locally with a clear message.
`npm run test:rust` behaves the same way when `cargo` is missing.

The Python binding smoke test requires Python development headers so it can
build the extension module. It parses sample MOO when the `tree_sitter` Python
runtime is installed. If headers or the runtime are not available locally,
`npm run test:python` skips with a clear message. In CI, missing binding
toolchains, headers, or runtime packages are treated as failures. The GitHub
workflows install Go from `bindings/go/go.mod`, Rust stable, Python 3.12, and
the Python Tree-sitter runtime.

The release-level Wasm build requires Emscripten, Docker, or Podman because it
runs `tree-sitter build --wasm`.

For local grammar development, start with:

```sh
git clone https://github.com/SindomeCorp/tree-sitter-moo.git
cd tree-sitter-moo
npm ci
npm run generate
```

## Test Tiers

Use these commands depending on the change:

```sh
npm test
```

Runs the focused Tree-sitter corpus tests. This is the fastest check and is the
default `npm test` target.

```sh
npm run test:corpus
```

Runs `tree-sitter test` against `test/corpus`. Add or update these tests when
changing `grammar.js` or when locking down syntax-tree shape for a bug fix.

```sh
npm run test:queries
```

Validates highlight captures, tag output, and mirrored query files. Run this
when changing grammar node names, `queries/highlights.scm`, `queries/tags.scm`,
or the mirrored files under `queries/moo`.

```sh
npm run test:fixtures
```

Strictly parses every `.moo` file under `fixtures/valid` and fails on
`ERROR` or `MISSING` nodes. This is broad smoke coverage for real examples; it
does not replace focused corpus tests.

```sh
npm run test:smoke
```

Loads the native Node binding, parses a representative sample, checks key node
types, and runs Go, Rust, Python, C, and Wasm parse smoke tests when their
local toolchains are installed.

```sh
npm run test:generated
```

Runs `npm run generate` and fails if generated parser artifacts under `src/`
are not committed.

```sh
npm run test:pr
```

Runs the normal pull-request suite:

```text
test:corpus -> test:queries -> test:fixtures -> test:smoke -> test:generated
```

Run this before opening a pull request.

```sh
npm run ci
```

Runs `test:pr`, builds the committed Wasm artifact, and validates the Wasm file.
Use this before release or when changing package/release behavior.

```sh
npm pack --dry-run
```

Verifies package contents without publishing. Pull-request CI runs this after
the PR test suite.

## What To Add

For grammar changes, add focused corpus cases under `test/corpus`. Prefer small
examples with explicit expected trees over adding many large fixture snapshots.

For real-world valid examples, update `fixtures/valid` through the fixture import
workflow and run `npm run test:fixtures`.

For editor-facing behavior, update `test/queries/sample.moo` and
`scripts/validate-queries.js` so query captures and tag output stay intentional.

For binding/package behavior, extend the smoke scripts instead of only relying
on package installation checks.

## Fixture Validation

Valid fixtures live under `fixtures/valid`. The strict validator parses every
fixture and fails if the syntax tree contains `ERROR` or `MISSING`.

Refresh fixtures from a local
[`moo-for-llms`](https://github.com/SindomeCorp/moo-for-llms) checkout with:

```sh
MOO_FOR_LLMS=/path/to/moo-for-llms npm run import:fixtures:all
npm run test:fixtures
```

Without `MOO_FOR_LLMS`, the importer expects `../moo-for-llms`. It strips the
training metadata string statements from imported examples so fixtures represent
server-provided raw verb bodies.

## CI Expectations

Pull requests run `npm run test:pr` and `npm pack --dry-run`.

Release validation runs `npm run ci`, verifies generated parser sources are
committed, builds native prebuilds, smoke-tests native prebuilds, validates
package contents, and smoke-tests the package before publishing.
