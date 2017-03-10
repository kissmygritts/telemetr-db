const promise = require('bluebird')
const _ = require('lodash')
const argv = require('minimist')(process.argv.slice(2))
const config = require('../config/database.json')[argv.e]
const options = { promiseLib: promise }
const pgp = require('pg-promise')(options)
const db = pgp(config)
const sql = require('../sql')

module.exports = {
  tables: () => {
    const query = pgp.helpers.concat(_.values(sql.tables))
    console.log(query)
  }
}
