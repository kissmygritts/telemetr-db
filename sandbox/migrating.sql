-- test devices
INSERT INTO devices (
  serial_num,
  frequency,
  vendor,
  device_type,
  model,
  mfg_date
)
VALUES
  ('030681', 218.997, 'ats', 'gps', null,'04/06/2011');

-- test animal
INSERT INTO animals (
  perm_id,
  cap_date,
  sex,
  age,
  species,
  serial_num,
  fate,
  fate_date
)
VALUES
  ('910', '2012/01/12', 'F', 'A', 'MULD', '030681', 'no collar', '2013/09/15'); -- outservice: '2013/09/15'

-- test animal without first adding the device
INSERT INTO animals (
  perm_id,
  cap_date,
  sex,
  age,
  species,
  serial_num,
  fate,
  fate_date
)
VALUES
  ('925', '2012/01/13', 'F', 'A', 'MULD', '030682', 'no collar', '2013/01/10'); -- outservice: '2013/01/10'




UPDATE deployments t
SET outservice = '2013/09/15'
FROM devices
WHERE t.device_id = devices.id AND devices.serial_num = '030681';

UPDATE deployments t
SET outservice = '2013/01/10'
FROM devices
WHERE t.device_id = devices.id AND devices.serial_num = '030682';
