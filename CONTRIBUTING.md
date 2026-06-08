# Contributing

Contributions are welcome.

## Development Setup

The public GitHub repository can be consumed directly by downstream projects:

```sh
npm install github:SindomeCorp/tree-sitter-moo
```

Pin a tag or branch for repeatable downstream installs while development is
active.

```sh
git clone https://github.com/SindomeCorp/tree-sitter-moo.git
cd tree-sitter-moo
npm ci
npm run generate
npm run ci
```

`npm run ci` builds the browser Wasm artifact. Make sure `emcc`, Docker, or
Podman is available before running it.

## Grammar Changes

When changing `grammar.js`:

1. Run `npm run generate`.
2. Add or update focused corpus tests under `test/corpus`.
3. Run `npm test`.
4. Run `npm run validate:fixtures`.
5. Run `npm run build:wasm`.
6. Commit generated files under `src/` and `dist/tree-sitter-moo.wasm` when
   they change.

## Fixture Changes

Fixtures under `fixtures/valid` are imported from
[`moo-for-llms`](https://github.com/SindomeCorp/moo-for-llms).

To refresh them:

```sh
MOO_FOR_LLMS=/path/to/moo-for-llms npm run import:fixtures:all
npm run validate:fixtures
```

Do not add invalid syntax examples under `fixtures/valid`. Valid fixtures must
parse without `ERROR` or `MISSING` nodes.

## Editor Queries

Neovim-compatible queries live under `queries/moo`. If you change highlights or
tags, test them in an editor and keep the query names aligned with grammar node
names in `src/node-types.json`.

## Pull Requests

Please include:

- a short description of the grammar/editor behavior changed
- tests or fixtures that exercise the change
- confirmation that `npm run ci` passes
