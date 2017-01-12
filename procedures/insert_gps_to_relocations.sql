INSERT INTO relocations (
  raw_gps_id,
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
  raw_gps.id AS raw_gps_id,
  deployments.device_id,
  deployments.animal_id,
  raw_gps.acq_time_utc,
  raw_gps.acq_time_lcl,
  raw_gps.longitude,
  raw_gps.latitude,
  raw_gps.altitude,
  raw_gps.activity,
  raw_gps.temperature
FROM deployments, devices, raw_gps
WHERE
  raw_gps.serial_num = devices.serial_num AND
  devices.id = deployments.device_id AND
  (
    (raw_gps.acq_time_lcl >= deployments.inservice AND
     raw_gps.acq_time_lcl <= deployments.outservice)
     OR
    (raw_gps.acq_time_lcl >= deployments.inservice AND
     deployments.outservice IS NULL)
  );
