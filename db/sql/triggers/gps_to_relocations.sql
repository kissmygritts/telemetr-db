/*
Functionally similar to gps_to_relocations, however this isn't looking
to check that the value is not in relocations. This is ideal for an initial insert (empty tables) as it reduces the overhead. However, in practice this should be updated to run the check that the NEW record doesn't already exist.
*/

CREATE OR REPLACE FUNCTION gps_to_relocations()
RETURNS trigger AS
$BODY$
BEGIN
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
    NEW.id AS gps_id,
    deployments.device_id,
    deployments.animal_id,
    NEW.acq_time_utc,
    NEW.acq_time_lcl,
    NEW.longitude,
    NEW.latitude,
    NEW.altitude,
    NEW.activity,
    NEW.temperature
  FROM deployments
    INNER JOIN devices ON deployments.device_id = devices.id
  WHERE
    NEW.serial_num = devices.serial_num AND
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

CREATE TRIGGER gps_to_relocations
  AFTER INSERT
  ON gps
  FOR EACH ROW
  EXECUTE PROCEDURE gps_to_relocations();
