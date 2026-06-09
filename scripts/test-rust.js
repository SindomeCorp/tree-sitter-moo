const { spawnSync } = require('node:child_process');

if (!hasCommand('cargo')) {
  skipOrFail('Rust binding tests', 'cargo not found');
}

const result = spawnSync('cargo', ['test'], {
  stdio: 'inherit',
});

process.exit(result.status ?? 1);

function hasCommand(command) {
  return spawnSync(command, ['--version'], { stdio: 'ignore' }).status === 0;
}

function skipOrFail(label, reason) {
  if (process.env.CI) {
    console.error(`${label} failed: ${reason}`);
    process.exit(1);
  }

  console.log(`Skipping ${label}: ${reason}`);
  process.exit(0);
}
