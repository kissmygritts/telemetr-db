-- insert gps into relocations where row is between a deployment and
-- not in relocations.gps_id. This should only insert new relocations.
-- TODO: this needs to be added to the import function for gps data
INSERT INTO relocations (
  gps_id,
  device_id,
  animal_id,
  acq_time_utc,
  acq_time_lcl,
  longitude,
  latitude,
  altitude,
  activity,
  temperature
)
SELECT
  gps.id AS gps_id,
  deployments.device_id,
  deployments.animal_id,
  gps.acq_time_utc,
  gps.acq_time_lcl,
  gps.longitude,
  gps.latitude,
  gps.altitude,
  gps.activity,
  gps.temperature
FROM deployments, devices, gps
WHERE
  gps.serial_num = devices.serial_num AND
  devices.id = deployments.device_id AND
  gps.id NOT IN (
    SELECT gps_id FROM relocations
  ) AND
  (
    (gps.acq_time_lcl >= deployments.inservice AND
     gps.acq_time_lcl <= deployments.outservice)
     OR
    (gps.acq_time_lcl >= deployments.inservice AND
     deployments.outservice IS NULL)
  );
