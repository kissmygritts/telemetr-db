CREATE TABLE lkp_study (
  id serial PRIMARY KEY,
  study_name varchar(100),
  attributes jsonb,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now()
);

COMMENT ON TABLE lkp_study IS
'List of all the studies for collar deployments';

-- seed the lkp_study table
INSERT INTO lkp_study (study_name)
VALUES
  ('Ruby Mtn'),
  ('Simpson Park'),
  ('Carson'),
  ('Battle Mtn'),
  ('Bald Mtn'),
  ('Pequop'),
  ('Carlin'),
  ('Wilson Crk'),
  ('Loyalton-Truckee'),
  ('Pine Nut'),
  ('SR 160'),
  ('NTTR'),
  ('NV-ID RMEL'),
  ('Lone Mtn - Garfield DBHS');
