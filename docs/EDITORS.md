# Editor Setup

This repository includes Tree-sitter queries for editor integrations. Neovim is
the primary tested editor integration for this grammar.

## Neovim

These instructions assume you already use
[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter).

### Config File Location

Put the Lua config in one of these places:

- Single-file config: `~/.config/nvim/init.lua`
- Modular config: `~/.config/nvim/lua/tree-sitter-moo.lua`, then add
  `require("tree-sitter-moo")` from `init.lua`
- LazyVim/lazy.nvim-style config:
  `~/.config/nvim/lua/plugins/tree-sitter-moo.lua`

### Minimal `init.lua` Setup

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

### lazy.nvim Example

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

### Highlight Queries

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

## Emacs 29+

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

## Helix

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

## Zed and VS Code

Zed and VS Code usually need an editor-specific extension package around the
Tree-sitter grammar. This repository has the generated parser and queries
needed to build those integrations, but first-class Zed and VS Code extensions
are not included yet.
