-- a function that will insert records into RELOCATIONS as long as
-- locations fall between the deployment dates for that animal.

CREATE OR REPLACE FUNCTION raw_gps_to_relocations()
RETURNS trigger AS
$BODY$
BEGIN
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
    NEW.id AS raw_gps_id,
    deployments.device_id,
    deployments.animal_id,
    NEW.acq_time_utc,
    NEW.acq_time_lcl,
    NEW.longitude,
    NEW.latitude,
    NEW.altitude,
    NEW.activity,
    NEW.temperature
  FROM deployments, devices
  WHERE
    NEW.serial_num = devices.serial_num AND
    devices.id = deployments.device_id AND
    (
      (NEW.acq_time_lcl >= deployments.inservice AND
       NEW.acq_time_lcl <= deployments.outservice)
       OR
      (NEW.acq_time_lcl >= deployments.inservice AND
       deployments.outservice IS NULL)
    );
  RETURN NULL;
END
$BODY$
LANGUAGE plpgsql VOLATILE
COST 100;
