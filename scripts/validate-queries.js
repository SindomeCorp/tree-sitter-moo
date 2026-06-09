const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');

const repoRoot = path.resolve(__dirname, '..');
const parserConfig = path.join(repoRoot, 'tree-sitter-config.json');
const fixture = path.join(repoRoot, 'test', 'queries', 'sample.moo');
const treeSitter = path.join(repoRoot, 'node_modules', '.bin', 'tree-sitter');

assertMirrors('highlights.scm');
assertMirrors('tags.scm');

const highlights = runTreeSitter([
  'query',
  '--captures',
  '--config-path',
  parserConfig,
  path.join(repoRoot, 'queries', 'highlights.scm'),
  fixture,
]);

for (const expected of [
  ['keyword', 'if'],
  ['function.method.call', 'tell'],
  ['function.call', 'max'],
  ['function.builtin', '$server'],
  ['constant.builtin', '$math'],
  ['constant.builtin', 'E_INVARG'],
  ['type.builtin', 'INT'],
  ['constant', '#12'],
  ['number', '1'],
  ['number.float', '2.5'],
  ['string', '"ready"'],
  ['property', 'name'],
  ['operator', '->'],
  ['punctuation.bracket', '{'],
  ['punctuation.delimiter', ';'],
]) {
  assertCapture(highlights.stdout, expected[0], expected[1]);
}

runTreeSitter([
  'query',
  '--test',
  '--config-path',
  parserConfig,
  path.join(repoRoot, 'queries', 'tags.scm'),
  fixture,
]);

const tags = runTreeSitter([
  'tags',
  '--config-path',
  parserConfig,
  fixture,
]);

for (const name of ['count', 'sys', 'total', 'kind', 'err', 'obj', 'parts', 'value', 'tags']) {
  if (!new RegExp(`^${name}\\s+\\|\\s+var\\s+\\tdef`, 'm').test(tags.stdout)) {
    throw new Error(`Missing assignment tag definition for ${name}`);
  }
}

console.log('Validated query captures, tag output, and mirrored query files.');

function assertMirrors(fileName) {
  const rootQuery = fs.readFileSync(path.join(repoRoot, 'queries', fileName), 'utf8');
  const editorQuery = fs.readFileSync(path.join(repoRoot, 'queries', 'moo', fileName), 'utf8');

  if (rootQuery !== editorQuery) {
    throw new Error(`queries/${fileName} and queries/moo/${fileName} are out of sync`);
  }
}

function assertCapture(output, capture, text) {
  const pattern = new RegExp(`capture: \\d+ - ${escapeRegExp(capture)}, .* text: \`${escapeRegExp(text)}\``);

  if (!pattern.test(output)) {
    throw new Error(`Missing @${capture} capture for ${text}`);
  }
}

function runTreeSitter(args) {
  const result = spawnSync(treeSitter, args, {
    cwd: repoRoot,
    encoding: 'utf8',
    env: {
      ...process.env,
      HOME: process.env.TREE_SITTER_VALIDATION_HOME || '/tmp',
      TREE_SITTER_DIR: process.env.TREE_SITTER_VALIDATION_DIR || '/tmp',
    },
  });

  if (result.status !== 0) {
    throw new Error(
      `tree-sitter ${args.join(' ')} failed\n${result.stdout || ''}${result.stderr || ''}`.trim()
    );
  }

  return result;
}

function escapeRegExp(value) {
  return value.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}
