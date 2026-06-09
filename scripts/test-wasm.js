const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');

const repoRoot = path.resolve(__dirname, '..');
const parserConfig = path.join(repoRoot, 'tree-sitter-config.json');
const treeSitter = path.join(repoRoot, 'node_modules', '.bin', 'tree-sitter');
const tmpRoot = path.join(repoRoot, 'build', 'test-wasm');
fs.mkdirSync(tmpRoot, { recursive: true });
const tmp = fs.mkdtempSync(path.join(tmpRoot, 'run-'));
const samplePath = path.join(tmp, 'sample.moo');
const cachePath = path.join(tmpRoot, 'cache');
const homePath = path.join(tmpRoot, 'home');
fs.mkdirSync(cachePath, { recursive: true });
fs.mkdirSync(homePath, { recursive: true });

fs.writeFileSync(samplePath, 'player:tell("Hello from MOO.");\nif ready\n  return [1..$];\nendif\n');

const result = spawnSync(treeSitter, ['parse', '--wasm', '--config-path', parserConfig, samplePath], {
  cwd: repoRoot,
  encoding: 'utf8',
  env: {
    ...process.env,
    HOME: process.env.TREE_SITTER_VALIDATION_HOME || homePath,
    TREE_SITTER_DIR: process.env.TREE_SITTER_VALIDATION_DIR || cachePath,
  },
});

const output = `${result.stdout || ''}${result.stderr || ''}`;

if (result.status !== 0 || /\b(ERROR|MISSING)\b/.test(output)) {
  console.error(output.trim());
  process.exit(result.status || 1);
}

for (const nodeType of ['verb_call', 'if_statement', 'range_literal']) {
  if (!output.includes(nodeType)) {
    console.error(`Wasm parser output did not include ${nodeType}`);
    console.error(output.trim());
    process.exit(1);
  }
}

console.log('Parsed sample MOO through the Wasm parser.');
