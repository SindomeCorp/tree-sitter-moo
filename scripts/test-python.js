const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');

const repoRoot = path.resolve(__dirname, '..');
const python = process.env.PYTHON || findPython();

if (!python || !hasPython(python)) {
  skipOrFail('Python binding tests', `${python || 'python3'} not found`);
}

const include = runPython([
  '-c',
  'import sysconfig; print(sysconfig.get_path("include") or "")',
]).stdout.trim();

if (!include || !fs.existsSync(path.join(include, 'Python.h'))) {
  skipOrFail('Python binding tests', 'Python development headers not found');
}

runPython(['setup.py', 'build_ext', '--inplace'], { stdio: 'inherit' });

runPython([
  '-c',
  [
    'import tree_sitter_moo',
    'language = tree_sitter_moo.language()',
    'assert isinstance(language, int)',
    'assert language != 0',
  ].join('; '),
], {
  env: {
    ...process.env,
    PYTHONPATH: path.join(repoRoot, 'bindings', 'python'),
  },
  stdio: 'inherit',
});

const runtimeCheck = spawnSync(python, ['-c', 'import tree_sitter'], {
  cwd: repoRoot,
  stdio: 'ignore',
});

if (runtimeCheck.status !== 0) {
  skipOrFail('Python parser smoke test', 'tree_sitter Python runtime not found');
}

runPython([
  '-c',
  `
import tree_sitter_moo
from tree_sitter import Language, Parser

source = b'''player:tell("Hello from MOO.");
if ready
  return [1..$];
endif
'''

language = Language(tree_sitter_moo.language())
parser = Parser()

if hasattr(type(parser), "language"):
    parser.language = language
else:
    parser.set_language(language)

tree = parser.parse(source)
root = tree.root_node

assert not root.has_error, root
tree_text = str(root)
assert "verb_call" in tree_text, tree_text
assert "if_statement" in tree_text, tree_text
assert "range_literal" in tree_text, tree_text
`,
], {
  env: {
    ...process.env,
    PYTHONPATH: path.join(repoRoot, 'bindings', 'python'),
  },
  stdio: 'inherit',
});

function findPython() {
  for (const candidate of ['python3', 'python']) {
    if (hasPython(candidate)) {
      return candidate;
    }
  }

  return null;
}

function hasPython(command) {
  return spawnSync(command, ['--version'], { stdio: 'ignore' }).status === 0;
}

function runPython(args, options = {}) {
  const result = spawnSync(python, args, {
    cwd: repoRoot,
    encoding: 'utf8',
    ...options,
  });

  if (result.status !== 0) {
    if (options.stdio === 'inherit') {
      process.exit(result.status ?? 1);
    }

    throw new Error(
      `${python} ${args.join(' ')} failed\n${result.stdout || ''}${result.stderr || ''}`.trim()
    );
  }

  return result;
}

function skipOrFail(label, reason) {
  if (process.env.CI) {
    console.error(`${label} failed: ${reason}`);
    process.exit(1);
  }

  console.log(`Skipping ${label}: ${reason}`);
  process.exit(0);
}
