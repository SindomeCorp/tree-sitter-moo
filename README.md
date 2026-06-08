# tree-sitter-moo

Tree-sitter grammar for MOO verb code. The grammar targets ToastStunt as the
initial superset dialect while keeping LambdaMOO compatibility in view.

## Status

This parser currently validates against 446 checked-in valid MOO verb fixtures
imported from `moo-for-llms`, with no `ERROR` or `MISSING` nodes.

Supported language surface includes:

- raw verb bodies in `.moo` files
- assignments, assignment expressions, scatter assignment, and list splicing
- `if` / `elseif` / `else`, `while`, `for`, `try` / `except`, and `fork`
- function calls, verb calls, `pass(...)`, property access, computed properties
- list literals, list indexing/ranges, numeric range literals
- ToastStunt map literals and map indexing
- inline error-catching expressions
- object refs, system objects, error constants, and type constants

## Scope

Version 1 parses raw verb bodies as provided by a MOO server. `.moo` files are
treated as plain verb code with no wrapper metadata, object declarations, or
database-dump syntax.

ToastStunt-only forms such as maps, `MAP`, `WAIF`, `ANON`, and `BOOL` are
accepted by default. A future dialect mode can distinguish ToastStunt from
LambdaMOO when tooling needs that distinction.

## Quick Start

```sh
git clone https://github.com/SindomeCorp/tree-sitter-moo.git
cd tree-sitter-moo
npm ci
npm run generate
npm test
npm run validate:fixtures
```

Useful commands:

```sh
npm run ci
npm run parse:fixtures
npx tree-sitter parse --config-path tree-sitter-config.json path/to/file.moo
```

## Fixtures

Valid fixtures live under `fixtures/valid`. The strict validator parses every
fixture and fails if the syntax tree contains `ERROR` or `MISSING`.

To refresh fixtures from a local `moo-for-llms` checkout:

```sh
MOO_FOR_LLMS=/path/to/moo-for-llms npm run import:fixtures:all
npm run validate:fixtures
```

Without `MOO_FOR_LLMS`, the importer expects `../moo-for-llms`. It strips the
training metadata string statements from imported examples so fixtures represent
server-provided raw verb bodies.

## Neovim

Add this to your Neovim config:

```lua
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.moo = {
  install_info = {
    url = "https://github.com/SindomeCorp/tree-sitter-moo",
    files = { "src/parser.c" },
    branch = "main",
  },
  filetype = "moo",
}

vim.filetype.add({ extension = { moo = "moo" } })
```

Then run:

```vim
:TSInstall moo
```

The same snippet is available in `nvim.lua`.

For local parser development, replace `url` with the path to your checkout.

## Release Checklist

1. Run `npm run ci`.
2. Commit generated `src/parser.c`, `src/grammar.json`, and `src/node-types.json`.
3. Push to GitHub and confirm Actions passes.
4. Tag a release once the first public API shape is acceptable.

## License

MIT
