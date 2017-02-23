CREATE VIEW undeployed_devices AS (
  SELECT
    devices.serial_num,
    devices.frequency,
    devices.vendor,
    devices.device_type,
    devices.mfg_date,
    devices.model
  FROM devices
    LEFT JOIN deployments ON devices.id = deployments.device_id
  WHERE deployments.device_id IS NULL
);

/*
-- this is the same as above using a NOT EXIST PATTERN
SELECT
  d.serial_num,
  d.frequency,
  d.vendor,
  d.device_type,
  d.mfg_date,
  d.model
FROM devices d
WHERE NOT EXISTS
  (
    SELECT device_id
    FROM deployments dep
    WHERE d.id = dep.device_id
  );
*/
