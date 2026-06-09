const fs = require('node:fs');
const path = require('node:path');

const wasmPath = path.resolve(__dirname, '..', 'dist', 'tree-sitter-moo.wasm');
const wasm = fs.readFileSync(wasmPath);

if (!WebAssembly.validate(wasm)) {
  throw new Error(`${path.relative(path.resolve(__dirname, '..'), wasmPath)} failed WebAssembly.validate`);
}

console.log(`Validated ${path.relative(path.resolve(__dirname, '..'), wasmPath)}`);
