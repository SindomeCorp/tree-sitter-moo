const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { spawnSync } = require('node:child_process');

const repoRoot = path.resolve(__dirname, '..');

if (!hasCommand(process.env.CC || 'cc')) {
  skipOrFail('C binding tests', `${process.env.CC || 'cc'} not found`);
}

const treeSitterHeader = path.join(repoRoot, 'node_modules', 'tree-sitter', 'vendor', 'tree-sitter', 'lib', 'include');
const treeSitterLib = path.join(repoRoot, 'node_modules', 'tree-sitter', 'build', 'Release', 'tree_sitter.a');

if (!fs.existsSync(path.join(treeSitterHeader, 'tree_sitter', 'api.h')) || !fs.existsSync(treeSitterLib)) {
  skipOrFail('C binding tests', 'Tree-sitter C runtime artifacts not found; run npm ci first');
}

const tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'tree-sitter-moo-c-'));
const sourcePath = path.join(tmp, 'smoke.c');
const exePath = path.join(tmp, 'smoke');

fs.writeFileSync(sourcePath, `
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <tree_sitter/api.h>
#include "tree-sitter-moo.h"

int main(void) {
  TSParser *parser = ts_parser_new();
  if (!ts_parser_set_language(parser, tree_sitter_moo())) {
    fprintf(stderr, "failed to set MOO language\\n");
    return 1;
  }

  const char *source = "player:tell(\\"Hello from MOO.\\");\\nif ready\\n  return [1..$];\\nendif\\n";
  TSTree *tree = ts_parser_parse_string(parser, NULL, source, (uint32_t)strlen(source));
  TSNode root = ts_tree_root_node(tree);

  if (ts_node_has_error(root)) {
    char *tree_string = ts_node_string(root);
    fprintf(stderr, "sample MOO parsed with errors: %s\\n", tree_string);
    free(tree_string);
    return 1;
  }

  ts_tree_delete(tree);
  ts_parser_delete(parser);
  return 0;
}
`);

run(process.env.CC || 'cc', [
  '-std=c11',
  '-I',
  treeSitterHeader,
  '-I',
  path.join(repoRoot, 'bindings', 'c'),
  sourcePath,
  path.join(repoRoot, 'src', 'parser.c'),
  treeSitterLib,
  '-o',
  exePath,
]);

run(exePath, []);

function hasCommand(command) {
  return spawnSync(command, ['--version'], { stdio: 'ignore' }).status === 0;
}

function run(command, args) {
  const result = spawnSync(command, args, {
    cwd: repoRoot,
    stdio: 'inherit',
  });

  if (result.status !== 0) {
    process.exit(result.status ?? 1);
  }
}

function skipOrFail(label, reason) {
  if (process.env.CI) {
    console.error(`${label} failed: ${reason}`);
    process.exit(1);
  }

  console.log(`Skipping ${label}: ${reason}`);
  process.exit(0);
}
