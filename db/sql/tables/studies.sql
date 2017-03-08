CREATE TABLE studies (
  id serial PRIMARY KEY,
  study_name varchar(100),
  attributes jsonb,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now()
);

COMMENT ON TABLE studies IS
'List of all the studies for collar deployments';

-- seed the lkp_study table
INSERT INTO studies (study_name)
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
