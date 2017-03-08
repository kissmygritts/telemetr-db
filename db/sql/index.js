'use strict'
const QueryFile = require('pg-promise').QueryFile
const path = require('path')

function sql (file) {
  const fullPath = path.join(__dirname, file)
  const options = {
    minify: true,
    debug: true
  }
  const qf = new QueryFile(fullPath, options)

  if (qf.error) {
    console.log(qf.error)
  }

  return qf
}

module.exports = {
  tables: {
    postGis: sql('tables/postgis.sql'),
    devices: sql('tables/devices.sql'),
    species: sql('tables/species.sql'),
    studies: sql('tables/studies.sql'),
    animals: sql('tables/animals.sql'),
    deployments: sql('tables/deployments.sql'),
    gps: sql('tables/gps.sql'),
    validityCodes: sql('tables/validity_codes.sql'),
    relocations: sql('tables/relocations.sql')
  },
  views: {
    activeDeployments: sql('views/active_deployments.sql'),
    animalDevice: sql('views/animal_device.sql'),
    relocsAnalysis: sql('views/relocs_analysis.sql'),
    undeployedDevices: sql('views/undeployed_devices.sql'),
    validityCount: sql('views/validity_count.sql')
  },
  triggers: {
    animalsToDeployments: sql('triggers/animals_to_deployments.sql'),
    gpsToRelocations: sql('triggers/gps_to_relocations.sql'),
    updatedAt: sql('triggers/updated_at.sql')
  },
  functions: {
    createGeom: sql('functions/create_geom.sql'),
    impossibleRelocs: sql('functions/impossible_relocs.sql'),
    improbableRelocs: sql('functions/improbable_relocs.sql'),
    nullRelocs: sql('functions/null_relocs.sql')
  }
}
