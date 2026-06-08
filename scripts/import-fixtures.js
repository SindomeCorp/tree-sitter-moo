const fs = require('node:fs');
const path = require('node:path');

const repoRoot = path.resolve(__dirname, '..');
const sourceRoot = process.env.MOO_FOR_LLMS || path.resolve(repoRoot, '..', 'moo-for-llms');
const sourceDir = path.join(sourceRoot, 'examples');
const targetDir = path.join(repoRoot, 'fixtures', 'valid');

const mode = process.argv.includes('--all') ? 'all' : 'syntax';
const files = mode === 'all'
  ? walk(sourceDir).filter(file => file.endsWith('.moo'))
  : [
      path.join(sourceDir, 'syntax', 'literals-and-values.moo'),
      path.join(sourceDir, 'syntax', 'assignment-and-operators.moo'),
      path.join(sourceDir, 'syntax', 'property-access.moo'),
      path.join(sourceDir, 'syntax', 'verb-calls.moo'),
      path.join(sourceDir, 'syntax', 'list-indexing-ranges.moo'),
      path.join(sourceDir, 'syntax', 'scatter-and-optional-args.moo'),
      path.join(sourceDir, 'syntax', 'conditionals.moo'),
      path.join(sourceDir, 'syntax', 'loops-break-continue.moo'),
      path.join(sourceDir, 'syntax', 'error-expression.moo'),
      path.join(sourceDir, 'syntax', 'try-except.moo'),
      path.join(sourceDir, 'syntax', 'fork-block.moo'),
      path.join(sourceDir, 'syntax', 'pass-call.moo'),
      path.join(sourceDir, 'syntax', 'toaststunt-map-literal.moo'),
      path.join(sourceDir, 'syntax', 'toaststunt-map-iteration.moo'),
      path.join(sourceDir, 'syntax', 'toaststunt-type-constants.moo'),
    ];

fs.rmSync(targetDir, { recursive: true, force: true });
fs.mkdirSync(targetDir, { recursive: true });

for (const sourcePath of files) {
  const relativePath = path.relative(sourceDir, sourcePath);
  const targetPath = path.join(targetDir, relativePath);
  const input = fs.readFileSync(sourcePath, 'utf8');
  fs.mkdirSync(path.dirname(targetPath), { recursive: true });
  fs.writeFileSync(targetPath, stripLeadingMetadata(input), 'utf8');
}

console.log(`Imported ${files.length} ${mode} fixtures into ${path.relative(repoRoot, targetDir)}`);

function stripLeadingMetadata(input) {
  const lines = input.split(/\r?\n/);
  let index = 0;

  while (index < lines.length && /^"[^"]*";\s*$/.test(lines[index])) {
    index += 1;
  }

  while (index < lines.length && lines[index].trim() === '') {
    index += 1;
  }

  return `${lines.slice(index).join('\n').trimEnd()}\n`;
}

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
