// Load Asciidoctor.js and the reveal.js converter
const asciidoctor = require('@asciidoctor/core')()
const asciidoctorRevealjs = require('@asciidoctor/reveal.js')
const kroki = require('asciidoctor-kroki')

asciidoctorRevealjs.register()
kroki.register(asciidoctor.Extensions)

// Convert the document 'presentation.adoc' using the reveal.js converter
const options = { safe: 'safe', backend: 'revealjs' }
asciidoctor.convertFile('index2.adoc', options)
