'use strict'

const sql = require('../sql').tables

module.exports = (rep, pgp) => {
  return {
    devices: () => rep.none(sql.devices),
    species: () => rep.none(sql.species),
    studies: () => rep.none(sql.studies)
  }
}
