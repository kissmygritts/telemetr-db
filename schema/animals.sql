CREATE TABLE animals (
  id serial PRIMARY KEY,
  perm_id varchar(20),
  cap_date date,
  sex varchar(8),
  age varchar(10),
  species varchar(4),
  notes varchar,
  serial_num varchar(50),
  fate varchar,
  fate_date date,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now()
);

CREATE INDEX perm_id_idx
ON animals (perm_id);

COMMENT ON TABLE animals IS 'All the animals that are captured and have a telemetry device deployed on them. This list should be updated when an animal dies or the collar is removed. This is the fate and fate_date';
