#!/usr/bin/env node
const gen = require('./db/bootstrap')
const init = require('./db/init')
const argv = require('minimist')(process.argv.slice(2))
const command = argv._[0]
const subcommand = argv._[1]

if (command === 'gen') {
  console.log(gen.tables())
} else if (command === 'init') {
  init.baseDir(),
  init.writeConfig(process.cwd())
}
