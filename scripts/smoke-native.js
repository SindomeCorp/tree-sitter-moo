const language = require("..");

if (language.name !== "moo") {
  throw new Error(`Expected language name "moo", got ${language.name}`);
}

if (!language.language) {
  throw new Error("Native language binding did not load");
}

if (!Array.isArray(language.nodeTypeInfo)) {
  throw new Error("nodeTypeInfo was not exported");
}

console.log(`Loaded ${language.name} native binding`);
