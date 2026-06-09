const { spawnSync } = require('node:child_process');

run('npm', ['run', 'generate']);
run('git', ['diff', '--exit-code', '--', 'src/parser.c', 'src/grammar.json', 'src/node-types.json']);

function run(command, args) {
  const result = spawnSync(command, args, {
    stdio: 'inherit',
  });

  if (result.status !== 0) {
    process.exit(result.status ?? 1);
  }
}
