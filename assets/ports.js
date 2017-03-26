'use strict'


// Remove 'require' so we can easily use Elm browser-based debugger
// App is imported in HTML instead. Keepin' it old school.
// const Elm = require('./elm.js')

// get a reference to the div where we will show our UI
let container = document.getElementById('container')

// start the elm app in the container
// and keep a reference for communicating with the app
let soundStager = Elm.Main.embed(container)
