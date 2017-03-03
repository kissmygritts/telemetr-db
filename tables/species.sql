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

INSERT INTO species (
  common_name,
  species_code,
  genus,
  species,
  sub_species
)
VALUES
('mule deer', 'MULD', 'Odocoileus', 'hemionus', ''),
('Rocky Mountain bighorn sheep', 'RBHS', 'Ovis', 'canadensis', 'canadensis'),
('desert bighorn sheep', 'DBHS', 'Ovis', 'canadensis', 'nelsoni'),
('California bighorn sheep', 'CBHS', 'Ovis', 'canadensis', 'ssp'),
('Rocky Mountain elk', 'RMEL', 'Cervus', 'elaphus', 'nelsoni'),
('mountain goat', 'MTGT', 'Oreamnos', 'americanus', ''),
('pronghorn antelope', 'PRGN', 'Antilocapra', 'americana', ''),
('mountain lion', 'MTLI', 'Puma', 'concolor', ''),
('American black bear', 'BLBR', 'Ursus', 'americanus', '');
