const fs = require("fs");

require("./smoke-native");

const wasmPath = require.resolve("tree-sitter-moo/wasm");
const wasm = fs.readFileSync(wasmPath);

if (!WebAssembly.validate(wasm)) {
  throw new Error(`${wasmPath} failed WebAssembly.validate`);
}

console.log(`Validated ${wasmPath}`);
