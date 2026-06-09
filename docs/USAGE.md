# Usage

Use this document for runtime APIs, parser artifacts, and command-line parsing.
For language-specific examples, see [`BINDINGS.md`](BINDINGS.md).

## Use the Wasm Parser

The npm package includes a browser-loadable Wasm parser artifact at
`tree-sitter-moo/wasm`, which maps to `dist/tree-sitter-moo.wasm`.

Use the package export to locate the Wasm file from Node-based tooling:

```js
const wasmPath = require.resolve("tree-sitter-moo/wasm");
```

Build or refresh the Wasm artifact from this repository with:

```sh
npm run build:wasm
```

The Tree-sitter CLI builds Wasm through Emscripten. See
[`../TESTING.md`](../TESTING.md) for local release-check prerequisites.

## Use in Node

The package exports the native Node binding at `tree-sitter-moo` and node type
metadata at `MOO.nodeTypeInfo`:

```js
const MOO = require("tree-sitter-moo");

console.log(MOO.name);
console.log(MOO.nodeTypeInfo.map((node) => node.type));
```

Native prebuilds are included for common Linux, macOS, and Windows targets. If
no prebuild is available for your platform, npm falls back to building the
binding from source with `node-gyp`.

The generated parser uses Tree-sitter language ABI 15, so the native Node
binding requires `tree-sitter` 0.25 or newer.

For the latest development build directly from GitHub, install from `main`:

```sh
npm install github:SindomeCorp/tree-sitter-moo#main
```

For repeatable builds, pin a release tag instead of `main`.

## Use the CLI

Use the Tree-sitter CLI directly when building tools, validating generated MOO,
or giving an LLM a syntax tree to inspect:

```sh
npx tree-sitter parse --config-path tree-sitter-config.json path/to/file.moo
```

For automated parser validation, see [`../TESTING.md`](../TESTING.md).

## Package Contents

The npm package includes the native Node binding, generated parser sources,
queries, and the Wasm parser artifact:

- `tree-sitter-moo`: native Node binding entry point
- `tree-sitter-moo/wasm`: `dist/tree-sitter-moo.wasm`
- `tree-sitter-moo/queries/highlights`: highlight query file
- `tree-sitter-moo/queries/tags`: tags query file

See [`../TESTING.md`](../TESTING.md) for package verification checks and
[`../RELEASE.md`](../RELEASE.md) for publishing.

For examples in each declared binding language, see
[`BINDINGS.md`](BINDINGS.md).
