'use strict'

// Home-made 'require' so we can use Elm browser-based debugger
// (while keeping the files separate in the browser too)
function requireInElectronOrBrowser(path, callback) {
    if (typeof require === 'function') {
        let Elm = require(path);
        callback(Elm);
    } else if (typeof document === 'object') {
        let head = document.getElementsByTagName('head')[0];
        let script = document.createElement('script');
        script.type = 'text/javascript';
        script.src = path;
        script.onload = function(event) {callback()};
        head.appendChild(script);
    }
}

let Elm, soundStager, container;
function elmSetup(elmObj) {
    Elm = elmObj || window.Elm;
    // get a reference to the div where we will show our UI
    container = document.getElementById('container')

    // start the elm app in the container
    // and keep a reference for communicating with the app
    soundStager = Elm.Main.embed(container)
    console.log('Elm ports setup OK')
}

requireInElectronOrBrowser('./elm.js', elmSetup);
