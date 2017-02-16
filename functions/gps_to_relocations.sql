/*
gps_to_relocations will trigger after insertion of each rod to the GPS table.
It will only insert data into relocations if the data meets the follow reqs
  1. acq_time_lcl is between the inservice date and outservice date for the device
  2. The row doesn't already exist in the relocations table. This is checked based on a psuedo index (serial_num || acq_time_lcl). In the event that a new record is entered that has the same serial_num and acq_time_lcl it will not be entered into the relocations table. This may be faulty as gps fixes may be sent twice if there wasn't sufficient satellite coverage for transmission.

TODO: consult CM & CS about point 2
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
  gps.serial_num || gps.acq_time_lcl NOT IN (
    -- checking rows don't already exist in relocations
    SELECT
      gps.serial_num || relocations.acq_time_lcl
    FROM gps
      INNER JOIN relocations ON gps.id = relocations.gps_id
  ) AND
  (
    (gps.acq_time_lcl >= deployments.inservice AND
     gps.acq_time_lcl <= deployments.outservice)
     OR
    (gps.acq_time_lcl >= deployments.inservice AND
     deployments.outservice IS NULL)
  );

RETURN NULL;
END
$BODY$
LANGUAGE plpgsql VOLATILE
COST 100;

-- comment on function
COMMENT ON FUNCTION gps_to_relocations() IS 'this function will insert newly entered gps data into the relocations table if it falls between a deployment and is not already in the database.';

-- drop trigger
DROP TRIGGER gps_to_relocations ON gps;

-- apply function to gps table as trigger
CREATE TRIGGER gps_to_relocations
  AFTER INSERT
  ON gps
  FOR EACH ROW
  EXECUTE PROCEDURE gps_to_relocations();
