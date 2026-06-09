# tree-sitter-moo

Tree-sitter grammar for MOO verb code. The grammar targets ToastStunt as the
initial superset dialect while keeping LambdaMOO compatibility in view.

## Use in Editors

### Neovim

These instructions assume you already use
[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter).

Neovim is the primary tested editor integration for this grammar.

#### Config File Location

Put the Lua config in one of these places:

- Single-file config: `~/.config/nvim/init.lua`
- Modular config: `~/.config/nvim/lua/tree-sitter-moo.lua`, then add
  `require("tree-sitter-moo")` from `init.lua`
- LazyVim/lazy.nvim-style config:
  `~/.config/nvim/lua/plugins/tree-sitter-moo.lua`

#### Minimal `init.lua` Setup

Add this to `~/.config/nvim/init.lua` after loading `nvim-treesitter`:

```lua
local parsers = require("nvim-treesitter.parsers")
local parser_config = parsers.get_parser_configs and parsers.get_parser_configs() or parsers

parser_config.moo = {
  install_info = {
    url = "https://github.com/SindomeCorp/tree-sitter-moo",
    files = { "src/parser.c" },
    branch = "main",
    queries = "queries/moo",
  },
  filetype = "moo",
}

vim.filetype.add({ extension = { moo = "moo" } })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "moo",
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
```

Then run:

```vim
:TSInstall moo
```

If your `nvim-treesitter` uses the current API, this also works from Lua:

```vim
:lua require("nvim-treesitter").install({ "moo" }):wait(300000)
```

Restart Neovim and verify a `.moo` file with:

```vim
:set filetype?
:InspectTree
```

You should see `filetype=moo` and a parsed syntax tree.

#### lazy.nvim Example

If you use `lazy.nvim`, create
`~/.config/nvim/lua/plugins/tree-sitter-moo.lua`:

```lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      local parsers = require("nvim-treesitter.parsers")
      local parser_config = parsers.get_parser_configs and parsers.get_parser_configs() or parsers

      parser_config.moo = {
        install_info = {
          url = "https://github.com/SindomeCorp/tree-sitter-moo",
          files = { "src/parser.c" },
          branch = "main",
          queries = "queries/moo",
        },
        filetype = "moo",
      }

      vim.filetype.add({ extension = { moo = "moo" } })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "moo",
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
}
```

Then restart Neovim and run:

```vim
:TSInstall moo
```

On the current `nvim-treesitter` rewrite, use this instead:

```vim
:lua require("nvim-treesitter").install({ "moo" }):wait(300000)
```

If you see `attempt to call field 'get_parser_configs' (a nil value)`, your
`nvim-treesitter` is using the newer parser API. Use the examples above as-is;
do not call `get_parser_configs()` directly.

#### Highlight Queries

This repository includes Neovim runtime queries under `queries/moo/`. If
highlighting does not start after installing the parser, add this repository to
your Neovim runtime path or copy the query files:

```sh
mkdir -p ~/.config/nvim/queries/moo
curl -L \
  https://raw.githubusercontent.com/SindomeCorp/tree-sitter-moo/main/queries/moo/highlights.scm \
  -o ~/.config/nvim/queries/moo/highlights.scm
```

The same parser snippet is available in `nvim.lua`.

For local parser development, replace `url` with the path to your checkout.

### Emacs 29+

Emacs can install and load the parser through its built-in Tree-sitter support.
Add this to your Emacs config:

```elisp
(setq treesit-language-source-alist
      '((moo "https://github.com/SindomeCorp/tree-sitter-moo" "main" "src")))

(unless (treesit-language-available-p 'moo)
  (treesit-install-language-grammar 'moo))

(define-derived-mode moo-ts-mode prog-mode "MOO"
  "Major mode for MOO using tree-sitter."
  (when (treesit-ready-p 'moo)
    (treesit-parser-create 'moo)))

(add-to-list 'auto-mode-alist '("\\.moo\\'" . moo-ts-mode))
```

This gives Emacs a parser-backed MOO mode. Highlighting and indentation need
additional Emacs mode work; the grammar and `queries/moo` files are the starting
point.

### Helix

Add the grammar to `~/.config/helix/languages.toml`:

```toml
[[language]]
name = "moo"
scope = "source.moo"
file-types = ["moo"]
grammar = "moo"

[[grammar]]
name = "moo"
source = { git = "https://github.com/SindomeCorp/tree-sitter-moo", rev = "main" }
```

Then fetch and build the grammar:

```sh
hx --grammar fetch
hx --grammar build
```

Helix query lookup depends on your runtime path. If highlighting is not picked
up automatically, copy the queries into your Helix runtime config:

```sh
mkdir -p ~/.config/helix/runtime/queries/moo
curl -L \
  https://raw.githubusercontent.com/SindomeCorp/tree-sitter-moo/main/queries/moo/highlights.scm \
  -o ~/.config/helix/runtime/queries/moo/highlights.scm
```

Open a `.moo` file and run `:tree-sitter-scopes` or inspect highlighting to
confirm the grammar loaded.

### Zed and VS Code

Zed and VS Code usually need an editor-specific extension package around the
Tree-sitter grammar. This repository has the generated parser and queries
needed to build those integrations, but first-class Zed and VS Code extensions
are not included yet.

## Use the Wasm Parser

The npm package includes a browser-loadable Wasm parser artifact at
`tree-sitter-moo/wasm`, which maps to `dist/tree-sitter-moo.wasm`.

Install directly from GitHub while the package is under active public
development:

```sh
npm install github:SindomeCorp/tree-sitter-moo
```

Pin a tag or branch when consuming it from another project:

```sh
npm install github:SindomeCorp/tree-sitter-moo#v0.2.4
```

Use the package export to locate the Wasm file from Node-based tooling:

```js
const wasmPath = require.resolve("tree-sitter-moo/wasm");
```

Build or refresh the Wasm artifact from this repository with:

```sh
npm run build:wasm
```

The Tree-sitter CLI builds Wasm through Emscripten. Ensure `emcc`, Docker, or
Podman is available before running `npm run build:wasm` or `npm run ci`.

## Use in Node

Install the parser with the core Tree-sitter runtime:

```sh
npm install tree-sitter tree-sitter-moo
```

Parse MOO code from Node:

```js
const Parser = require("tree-sitter");
const MOO = require("tree-sitter-moo");

const parser = new Parser();
parser.setLanguage(MOO);

const source = 'player:tell("Hello from MOO.");';
const tree = parser.parse(source);

console.log(tree.rootNode.toString());
```

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

## Use the CLI

Use the Tree-sitter CLI directly when building tools, validating generated MOO,
or giving an LLM a syntax tree to inspect:

```sh
npx tree-sitter parse --config-path tree-sitter-config.json path/to/file.moo
```

For quiet validation in scripts:

```sh
npm run validate:fixtures
```

## Package Contents

The npm package includes the native Node binding, generated parser sources,
queries, and the Wasm parser artifact:

- `tree-sitter-moo`: native Node binding entry point
- `tree-sitter-moo/wasm`: `dist/tree-sitter-moo.wasm`
- `tree-sitter-moo/queries/highlights`: highlight query file
- `tree-sitter-moo/queries/tags`: tags query file

Before publishing or tagging a release, verify package contents with:

```sh
npm pack --dry-run
```

## Status

This parser currently validates against 446 checked-in valid MOO verb fixtures
imported from
[`moo-for-llms`](https://github.com/SindomeCorp/moo-for-llms), with no `ERROR`
or `MISSING` nodes.

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

## Develop the Grammar

For local grammar development:

```sh
git clone https://github.com/SindomeCorp/tree-sitter-moo.git
cd tree-sitter-moo
npm ci
npm run generate
```

Run the test suite:

```sh
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

See `fixtures/README.md` for fixture provenance, licensing, and import
behavior.

To refresh fixtures from a local
[`moo-for-llms`](https://github.com/SindomeCorp/moo-for-llms) checkout:

```sh
MOO_FOR_LLMS=/path/to/moo-for-llms npm run import:fixtures:all
npm run validate:fixtures
```

Without `MOO_FOR_LLMS`, the importer expects `../moo-for-llms`. It strips the
training metadata string statements from imported examples so fixtures represent
server-provided raw verb bodies.

## Project Documents

- `CHANGELOG.md`: release notes and known gaps
- `CONTRIBUTING.md`: development and pull request workflow
- `RELEASE.md`: npm release workflow and checklist
- `SECURITY.md`: security reporting policy
- `ROADMAP.md`: planned follow-up work
- `fixtures/README.md`: fixture provenance and validation policy

## Release Checklist

See `RELEASE.md` for the npm release workflow, native prebuild targets,
trusted publishing setup, and per-version release checklist.

## License

MIT. See `LICENSE`.
