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

// console.log('command: ' + command)
// console.log('subcommand: ' + subcommand)

const sql = require('./db/sql')
let query = ''

if (command === 'init') {
  const tables = require('./db/sql').tables
  const views = require('./db/sql').views
  const triggers = require('./db/sql').triggers
  const functions = require('./db/sql').functions

  console.log('creating telemeter database resources: ' + subcommand)

  if (subcommand === 'tables') {
    query = pgp.helpers.concat(_.values(tables))
  } else if (subcommand === 'views') {
    query = pgp.helpers.concat(_.values(views))
  } else if (subcommand === 'triggers') {
    query = pgp.helpers.concat(_.values(triggers))
  } else if (subcommand === 'functions') {
    query = pgp.helpers.concat(_.values(functions))
  } else {
    console.error('bad subcommand:', subcommand)
    process.exit(1)
  }

  db.none(query)
  .then(() => console.log('telemetr ' + subcommand + ' created'))
  .catch(err => console.error('ERROR: ' + subcommand + ' was not created.', err))
}
