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
  ('910', '2012/01/12', 'F', 'A', 'MULD', '030681', 'no collar', '2013/09/15'),
  ('925', '2012/01/13', 'F', 'A', 'MULD', '030682', 'no collar', '2013/01/10');

-- testing with an animal that has multiple deployments
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
  ('1596', '2013-01-06', 'F', 'A', 'MULD', '031812', 'new collar', '2015-01-23'),
  ('1596', '2015-01-23', 'F', 'A', 'MULD', '030750', 'new collar', '2016-01-22'),
  ('1596', '2016-01-22', 'F', 'A', 'MULD', '40729', null, null);
