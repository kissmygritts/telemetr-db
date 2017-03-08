#!/usr/bin/env node
const promise = require('bluebird')
const _ = require('lodash')
const argv = require('minimist')(process.argv.slice(2))
const config = require('./db/config/database.json')[argv.e]
const options = { promiseLib: promise }
const pgp = require('pg-promise')(options)
const db = pgp(config)
const command = argv._[0]
const subcommand = argv._[1]

console.log('command: ' + command)
console.log('subcommand: ' + subcommand)

const sql = require('./db/sql')
let query = ''

if (command === 'bootstrap') {
  const tables = require('./db/sql').tables
  const views = require('./db/sql').views

  if (subcommand === 'tables') {
    query = pgp.helpers.concat(_.values(tables))
  } else if (subcommand === 'views') {
    query = pgp.helpers.concat(_.values(views))
  }

  console.log(query)

  db.none(query)
  .then(() => console.log('telemetr ' + subcommand + ' created'))
  .catch(err => console.error('ERROR: ' + subcommand + ' was not created.', err))
}
