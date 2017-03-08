CREATE TABLE animals (
  id serial PRIMARY KEY,
  perm_id integer,
  species_id integer REFERENCES species(id),
  serial_num varchar(50) REFERENCES devices(serial_num),
  cap_date date,
  sex varchar(8),
  age varchar(10),
  study_id integer REFERENCES studies(id),
  fate varchar,
  fate_date date,
  notes varchar,
  attributes jsonb,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now()
);

CREATE INDEX perm_id_idx
ON animals (perm_id);

COMMENT ON TABLE animals IS
'All the animals that are captured and have a telemetry device deployed on them. This list should be updated when an animal dies or the collar is removed. This is the fate and fate_date';

-- TODO: if an animal is deleted then it's deployment needs to be deleted, so does any relocation data from relocations.
-- QUESTION: what about raw gps data? Why would an animal be deleted after data is entered? Is it a reasonable expectation that the gps data should be deleted as well?
-- QUESTION: As currently implemented this creates a one-to-one relationship with deployments. Every time an animal is recaptured and a new collar is put on that animal it the fate_date must be updated from the original record and the new one entered. I'm treating animals as a captures table. However, it works, and I need to move on.
-- TODO: figure out one-to-many captures-animals-deployments work flow.
