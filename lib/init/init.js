const fs = require('fs')

module.exports = {
  writeConfig: (wd) => {
    console.log(wd)
    fs.writeFileSync(wd + '/config.json',
      JSON.stringify({
        development: {
          user: null,
          password: null,
          database: 'telemetr_dev',
          host: '127.0.0.1',
          port: 5432
        },
        test: {
          user: null,
          password: null,
          database: 'telemetr_test',
          host: '127.0.0.1',
          port: 5432
        },
        production: {
          user: null,
          password: null,
          database: 'telemetr_prod',
          host: '127.0.0.1',
          port: 5432
        }
      }, undefined, 2) + '\n'
  )
  }
}
