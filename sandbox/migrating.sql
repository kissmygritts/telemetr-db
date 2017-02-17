INSERT INTO captures (
  perm_id,
  cap_date,
  sex,
  age,
  species,
  serial_num
)
VALUES
  ('910', '2012/01/12', 'F', 'A', 'MULD', '030681'), -- outservice: '2013/09/15'
  ('925', '2012/01/13', 'F', 'A', 'MULD', '030682'); -- outservice: '2013/01/10'

UPDATE deployments t
SET outservice = '2013/09/15'
FROM devices
WHERE t.device_id = devices.id AND devices.serial_num = '030681';

UPDATE deployments t
SET outservice = '2013/01/10'
FROM devices
WHERE t.device_id = devices.id AND devices.serial_num = '030682';

-- what happens if I attempt to enter a recapture?

-- okay new idea

CREATE TABLE animals (
  id serial PRIMARY KEY,
  perm_id varchar(20),
  cap_date date,
  sex varchar(8),
  age varchar(10),
  species varchar(4),
  notes varchar,
  serial_num varchar(50),
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now()
);
