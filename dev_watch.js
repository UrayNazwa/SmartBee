const { spawn } = require('child_process');
const chokidar = require('./smartbee_backend/node_modules/chokidar');
const path = require('path');

console.log('-----------------------------------');
console.log('Starting SmartBee Auto-Watcher...');
console.log('-----------------------------------');

// 1. Start Backend
const backend = spawn('node', ['index.js'], {
  cwd: path.join(__dirname, 'smartbee_backend'),
  stdio: 'inherit'
});

// 2. Start Frontend
const frontend = spawn('flutter', ['run', '-d', 'chrome', '--web-port', '5500'], {
  cwd: path.join(__dirname, 'smartbee_app'),
  stdio: ['pipe', 'inherit', 'inherit']
});

console.log('Watching for changes in smartbee_app/lib...');

// 3. Watch for changes
const watcher = chokidar.watch(path.join(__dirname, 'smartbee_app/lib'), {
  persistent: true,
  ignoreInitial: true
});

let lastReload = Date.now();

watcher.on('all', (event, filePath) => {
  const now = Date.now();
  // Debounce 1 second to avoid multiple reloads
  if (now - lastReload > 1000) {
    console.log(`\nChange detected: ${path.basename(filePath)}. Reloading...`);
    frontend.stdin.write('R'); // Send Hot Restart command
    lastReload = now;
  }
});

process.on('SIGINT', () => {
  console.log('\nStopping watcher...');
  backend.kill();
  frontend.kill();
  process.exit();
});
