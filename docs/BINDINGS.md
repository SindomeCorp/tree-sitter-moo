# Language Bindings

This grammar declares bindings for Node, Go, Python, Rust, C, and Swift. These
examples show the minimum expected usage for each binding: load the language,
attach it to the host Tree-sitter runtime where applicable, and parse a small
MOO snippet.

CI smoke-tests sample parsing for Node, Wasm, Go, Rust, Python, and C. Swift is
declared for package-manager/editor compatibility, but it is not currently
covered by CI.

## Node

Install the native package with the Tree-sitter runtime:

```sh
npm install tree-sitter@^0.25.0 tree-sitter-moo
```

Parse a snippet:

```js
const Parser = require("tree-sitter");
const MOO = require("tree-sitter-moo");

const parser = new Parser();
parser.setLanguage(MOO);

const tree = parser.parse('player:tell("Hello from MOO.");');

console.log(tree.rootNode.toString());
```

The package also exports `MOO.nodeTypeInfo` from `src/node-types.json`.

## Wasm

The npm package exposes the Wasm artifact at `tree-sitter-moo/wasm`:

```js
const wasmPath = require.resolve("tree-sitter-moo/wasm");
```

Use that path with the Tree-sitter runtime or editor tooling that accepts a
browser-loadable parser artifact.

## Go

The Go binding exposes a Tree-sitter language pointer:

```go
package main

import (
	"fmt"

	tree_sitter "github.com/tree-sitter/go-tree-sitter"
	tree_sitter_moo "github.com/SindomeCorp/tree-sitter-moo"
)

func main() {
	language := tree_sitter.NewLanguage(tree_sitter_moo.Language())
	parser := tree_sitter.NewParser()
	if err := parser.SetLanguage(language); err != nil {
		panic(err)
	}

	tree := parser.Parse([]byte(`player:tell("Hello from MOO.");`), nil)
	fmt.Println(tree.RootNode().ToSexp())
}
```

## Rust

Add the crate to a Rust project, then pass its language into a Tree-sitter
parser:

```rust
fn main() {
    let mut parser = tree_sitter::Parser::new();
    parser
        .set_language(&tree_sitter_moo::language())
        .expect("Error loading Moo grammar");

    let tree = parser
        .parse(r#"player:tell("Hello from MOO.");"#, None)
        .expect("parser returned no tree");

    println!("{}", tree.root_node().to_sexp());
}
```

The Rust binding also exposes `tree_sitter_moo::NODE_TYPES`.

## Python

The Python binding exposes `language()` from `tree_sitter_moo`. With the
Tree-sitter Python runtime installed:

```python
import tree_sitter_moo
from tree_sitter import Language, Parser

language = Language(tree_sitter_moo.language())
parser = Parser(language)

tree = parser.parse(b'player:tell("Hello from MOO.");')

print(tree.root_node)
```

The exact parser setup can vary slightly by `tree-sitter` Python runtime
version, but `tree_sitter_moo.language()` is the grammar entrypoint.

## C

The C binding exposes the generated language symbol through
`bindings/c/tree-sitter-moo.h`:

```c
#include <tree_sitter/api.h>
#include "tree-sitter-moo.h"

int main(void) {
  TSParser *parser = ts_parser_new();
  ts_parser_set_language(parser, tree_sitter_moo());

  const char *source = "player:tell(\"Hello from MOO.\");";
  TSTree *tree = ts_parser_parse_string(parser, NULL, source, strlen(source));

  ts_tree_delete(tree);
  ts_parser_delete(parser);
  return 0;
}
```

Link this with the Tree-sitter C runtime and the generated parser sources.

## Swift

The Swift package exposes the C language symbol through
`TreeSitterMoo/moo.h`:

```swift
import TreeSitterMoo

let language = tree_sitter_moo()
```

Use that language pointer with Swift Tree-sitter wrappers or editor tooling that
can consume a `TSLanguage` from a Swift package target.

Swift parsing is not currently verified in CI.
