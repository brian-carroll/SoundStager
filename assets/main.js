'use strict'
const electron = require('electron')
const chokidar = require('chokidar') // add chokidar

const app = electron.app
const BrowserWindow = electron.BrowserWindow

let mainWindow

app.on('ready', createWindow)


// tell chokidar to watch these files for changes
// reload the window if there is one
let timeout;
let watcher = chokidar.watch(['dist'], {
    awaitWriteFinish: {
      stabilityThreshold: 200,
      pollInterval: 100
    },
});
watcher.on('change', (path, stats) => {
    if (!mainWindow) return;
    console.log('Reloading after change in '
        + path + ', ' + stats.mtime
    )
    mainWindow.reload();
})

function createWindow () {
  mainWindow = new BrowserWindow({
    width: 1024,
    height: 768
  })

  mainWindow.loadURL(`file://${ __dirname }/index.html`)

  mainWindow.webContents.openDevTools()

  mainWindow.on('closed', function () {
    mainWindow = null
  })
}

/* Mac Specific things */

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') { app.quit() }
})

app.on('activate', () => {
  if (mainWindow === null) { createWindow() }
})
