-- 2415566 rows
SELECT count(*)
FROM gps;

-- 2272708 rows
WITH relocs AS (
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
  FROM (gps
    INNER JOIN devices ON gps.serial_num = devices.serial_num)
    INNER JOIN deployments ON devices.id = deployments.id
)

SELECT count(*)
FROM relocs;

-- 2144059 rows
WITH relocs AS (
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
  FROM (gps
    INNER JOIN devices ON gps.serial_num = devices.serial_num)
    INNER JOIN deployments ON devices.id = deployments.id
  WHERE
    (
      gps.acq_time_lcl >= deployments.inservice AND
      gps.acq_time_lcl <= deployments.outservice
    ) OR (
      gps.acq_time_lcl >= deployments.inservice
    )
)

SELECT count(*)
FROM relocs;

-- count of all deployments, should = 1383 (from access). True
SELECT count(*)
FROM deployments;

-- are there any animals not in deployments: No, they are all in there
SELECT perm_id
FROM animals
WHERE id NOT IN (
  SELECT animal_id FROM deployments
);

-- any devices not in deployments? YES, lots of VHF (likely) = 218
COPY (
  SELECT serial_num, device_type
  FROM devices
  WHERE id NOT IN (
    SELECT device_id FROM deployments
  )
)
TO '/Users/mitchellgritts/documents/telemetr/telemetr-db/data/undeployed-devices.csv'
WITH CSV DELIMITER ',';

-- rows = 2415566
WITH relocs AS (
SELECT
  gps.id AS gps_id,
  -- deployments.device_id,
  -- deployments.animal_id,
  gps.acq_time_utc,
  gps.acq_time_lcl,
  gps.longitude,
  gps.latitude,
  gps.altitude,
  gps.activity,
  gps.temperature
FROM (gps LEFT JOIN devices ON gps.serial_num = devices.serial_num)
)
-- in this query LEFT JOIN and INNER JOIN produce the same result
SELECT count(*)
FROM relocs;

--
WITH relocs AS (
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
FROM (gps
  LEFT JOIN devices ON gps.serial_num = devices.serial_num)
  LEFT JOIN deployments ON devices.id = deployments.device_id
WHERE
  (
    gps.acq_time_lcl >= deployments.inservice AND
    gps.acq_time_lcl <= deployments.outservice
  ) OR (
    gps.acq_time_lcl >= deployments.inservice
  )
)
-- in this query LEFT JOIN and INNER JOIN produce differing results. LEFT JOIN returns all the rows
SELECT count(*)
FROM relocs;
