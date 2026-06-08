const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');

const repoRoot = path.resolve(__dirname, '..');
const target = process.argv[2] || 'fixtures/valid';
const root = path.resolve(repoRoot, target);
const parserConfig = path.join(repoRoot, 'tree-sitter-config.json');

if (!fs.existsSync(root)) {
  console.error(`Fixture path does not exist: ${path.relative(repoRoot, root)}`);
  process.exit(1);
}

const files = walk(root).filter(file => file.endsWith('.moo')).sort();

if (files.length === 0) {
  console.error(`No .moo fixtures found under ${path.relative(repoRoot, root)}`);
  process.exit(1);
}

const failures = [];

for (const file of files) {
  const result = spawnSync(
    path.join(repoRoot, 'node_modules', '.bin', 'tree-sitter'),
    ['parse', '--config-path', parserConfig, file],
    {
      cwd: repoRoot,
      encoding: 'utf8',
      env: {
        ...process.env,
        HOME: process.env.TREE_SITTER_VALIDATION_HOME || '/tmp',
        TREE_SITTER_DIR: process.env.TREE_SITTER_VALIDATION_DIR || '/tmp',
      },
    }
  );

  const output = `${result.stdout || ''}${result.stderr || ''}`;

  if (result.status !== 0 || /\b(ERROR|MISSING)\b/.test(output)) {
    failures.push({
      file: path.relative(repoRoot, file),
      status: result.status,
      output,
    });
  }
}

if (failures.length > 0) {
  for (const failure of failures.slice(0, 25)) {
    console.error(`\n--- ${failure.file} ---`);
    console.error(failure.output.trim());
  }

  if (failures.length > 25) {
    console.error(`\n... ${failures.length - 25} additional failures omitted`);
  }

  console.error(`\n${failures.length} of ${files.length} fixtures failed strict parse validation.`);
  process.exit(1);
}

console.log(`Validated ${files.length} fixtures with no ERROR or MISSING nodes.`);

function walk(dir) {
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  const files = [];

  for (const entry of entries) {
    const fullPath = path.join(dir, entry.name);

    if (entry.isDirectory()) {
      files.push(...walk(fullPath));
    } else if (entry.isFile()) {
      files.push(fullPath);
    }
  }

  return files;
}
