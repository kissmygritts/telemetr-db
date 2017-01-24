-- test devices
INSERT INTO devices
  (serial_num, vendor)
VALUES
  ('device1', 'test'),
  ('device2', 'test'),
  ('device3', 'test');

SELECT * FROM DEVICES;
DELETE FROM devices WHERE vendor = 'test';

-- captures
INSERT INTO captures
  (perm_id, cap_date, sex, age, species, notes, serial_num)
VALUES
  ('test1', '2017-01-01', 'male', 'adult', 'TEST', 'notes notes', 'device1');

SELECT * FROM captures;
SELECT * FROM animals;
SELECT * FROM deployments;
SELECT * FROM collar_deployments;

DELETE FROM animals WHERE perm_id = 'test1';
DELETE FROM deployments WHERE id = 6;

-- what happens if I try to delete this capture (no cascade/triggers)
DELETE FROM captures WHERE perm_id = 'test1';
-- test
SELECT * FROM captures;
SELECT * FROM animals;
SELECT * FROM deployments;
/*
ANS: it will run without error, and delete the capture. However
it doesn't delete the deployment or animal
*/

/* What if I set ON DELETE CASCADE */
alter table deployments
drop constraint deployments_animal_id_fkey,
add constraint deployments_animal_id_fkey
   foreign key (animal_id)
   references animals(id)
   on delete cascade;
--
INSERT INTO captures
  (perm_id, cap_date, sex, age, species, notes, serial_num)
VALUES
  ('test1', '2017-01-01', 'male', 'adult', 'TEST', 'notes notes', 'device1');
--
DELETE FROM animals WHERE perm_id = 'test1';
--
SELECT * FROM deployments;
-- It did delete the record!
-- Now to have a animals and deployments delete when a capture is deleted
CREATE OR REPLACE FUNCTION delete_capture()
RETURNS trigger AS
$BODY$
BEGIN
  DELETE FROM animals
  WHERE perm_id = OLD.perm_id;

  RETURN OLD;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER delete_capture
  AFTER DELETE
  ON captures
  FOR EACH ROW
  EXECUTE PROCEDURE delete_capture();

DELETE FROM captures WHERE perm_id = 'test1';





-- what will happen if I try this for a recapture?
-- ANS: it will try to enter the original deployment into deployments
-- no unique on animals.perm_id, capture.perm_id, captures.serial_num
INSERT INTO captures
  (perm_id, cap_date, sex, age, species, notes, serial_num)
VALUES
  ('test1', '2017-01-01', 'male', 'adult', 'TEST', 'notes notes', 'device2');
