const language = require("..");
const Parser = require("tree-sitter");

if (language.name !== "moo") {
  throw new Error(`Expected language name "moo", got ${language.name}`);
}

if (!language.language) {
  throw new Error("Native language binding did not load");
}

if (!Array.isArray(language.nodeTypeInfo)) {
  throw new Error("nodeTypeInfo was not exported");
}

const parser = new Parser();
parser.setLanguage(language);

const tree = parser.parse(`
if ready
  player:tell("Hello from MOO.");
endif

{name, ?label = "item", @rest} = args;
result = [1..$];
value = \`object.prop ! E_PERM => 0';
`);

const syntaxTree = tree.rootNode.toString();

for (const nodeType of [
  "if_statement",
  "verb_call",
  "scatter_pattern",
  "optional_scatter_element",
  "rest_scatter_element",
  "range_literal",
  "inline_error_expression",
]) {
  if (!syntaxTree.includes(nodeType)) {
    throw new Error(`Native parser smoke sample did not include ${nodeType}`);
  }
}

console.log(`Loaded ${language.name} native binding`);
