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

const tree = parser.parse('player:tell("Hello from MOO.");');
if (!tree.rootNode.toString().includes("verb_call")) {
  throw new Error("Native parser did not parse a sample verb call");
}

console.log(`Loaded ${language.name} native binding`);
