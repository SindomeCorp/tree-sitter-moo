# tree-sitter-moo

Tree-sitter grammar for MOO verb code. The grammar targets ToastStunt as the
initial superset dialect while keeping LambdaMOO compatibility in view.

## Install

Install the parser with the core Tree-sitter runtime:

```sh
npm install tree-sitter@^0.25.0 tree-sitter-moo
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

The package exports the native Node binding at `tree-sitter-moo`, a
browser-loadable Wasm parser at `tree-sitter-moo/wasm`, and query files for
editor integrations.

## Supported Syntax

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
- durable MOO string-literal comments, exposed as `comment` nodes

Version 1 parses raw verb bodies as provided by a MOO server. `.moo` files are
treated as plain verb code with no wrapper metadata, object declarations, or
database-dump syntax.

Stored verb code uses standalone string-literal statements for durable comments.
Parser-discarded forms such as `// ...` and `/* ... */` are not treated as MOO
comments by this grammar because they are not portable stored verb code.

ToastStunt-only forms such as maps, `MAP`, `WAIF`, `ANON`, and `BOOL` are
accepted by default. A future dialect mode can distinguish ToastStunt from
LambdaMOO when tooling needs that distinction.

## Documentation

- [Usage](docs/USAGE.md): Node API, Wasm parser, CLI usage, and package exports
- [Language bindings](docs/BINDINGS.md): Node, Wasm, Go, Rust, Python, C, and Swift examples
- [Editor setup](docs/EDITORS.md): Neovim, Emacs, Helix, and extension notes
- [Testing](TESTING.md): local test tiers, fixture validation, and CI expectations
- [Contributing](CONTRIBUTING.md): development and pull request workflow
- [Fixtures](https://github.com/SindomeCorp/tree-sitter-moo/blob/main/fixtures/README.md): fixture provenance and validation policy
- [Release process](RELEASE.md): npm release workflow and checklist
- [Security](SECURITY.md): security reporting policy
- [Roadmap](ROADMAP.md): planned follow-up work
- [Changelog](CHANGELOG.md): release notes and known gaps

## License

MIT. See [LICENSE](LICENSE).
