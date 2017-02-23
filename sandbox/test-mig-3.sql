-- 12375
SELECT * FROM animal_device WHERE serial_num = '12375';
-- two deployments!
SELECT count(*) FROM gps WHERE serial_num = '12375'; -- 3962 rows

-- inservice = 2016-01-25
-- outservice == null
-- min acq_time_lcl = 2016-01-25 16:01:03-08
SELECT * FROM gps WHERE serial_num = '12375' ORDER BY acq_time_lcl ASC;
-- max acq_time_lcl = 2017-01-03 04:00:39-08
SELECT * FROM gps WHERE serial_num = '12375' ORDER BY acq_time_lcl DESC;

-- number of rows for device = 3962
SELECT count(*)
FROM gps
WHERE serial_num = '12375';

-- count of rows with join = 3962
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
    INNER JOIN deployments ON devices.id = deployments.device_id
  WHERE
    gps.serial_num = '12375'
)

SELECT count(*)
FROM relocs;

-- count of rows with deployments = 3962
WITH relocs AS (
  SELECT
    gps.id AS gps_id,
    gps.serial_num,
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
    INNER JOIN deployments ON devices.id = deployments.device_id
  WHERE
    gps.serial_num = '12375' AND (
      (
        gps.acq_time_lcl >= deployments.inservice AND
        gps.acq_time_lcl <= deployments.outservice
      ) OR (
        gps.acq_time_lcl >= deployments.inservice
      )
    )
  ORDER BY gps.acq_time_lcl DESC
)

SELECT count(*)
FROM relocs;
