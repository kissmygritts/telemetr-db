CREATE TABLE species (
  id serial PRIMARY KEY,
  common_name varchar(100),
  species_code varchar(4),
  genus varchar(50),
  species varchar(50),
  sub_species varchar(50),
  attributes jsonb,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now()
);

COMMENT ON TABLE species IS
'Lookup table for species in telemetr database.';
