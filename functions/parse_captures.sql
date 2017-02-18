CREATE OR REPLACE FUNCTION animals_to_deployments()
RETURNS trigger AS
$BODY$
BEGIN

  INSERT INTO deployments (
    animal_id,
    device_id,
    inservice,
    outservice
  )
  SELECT
    NEW.id AS animal_id,
    devices.id AS device_id,
    NEW.cap_date AS inservice,
    NEW.fate_date AS outservice
  FROM animals
    INNER JOIN devices ON NEW.serial_num = devices.serial_num;

  RETURN NULL;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
COST 100;

CREATE TRIGGER animals_to_deployments
  AFTER INSERT
  ON animals
  FOR EACH ROW
  EXECUTE PROCEDURE animals_to_deployments();
