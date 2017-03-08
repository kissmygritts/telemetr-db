CREATE TABLE studies (
  id serial PRIMARY KEY,
  study_name varchar(100),
  attributes jsonb,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now()
);

COMMENT ON TABLE studies IS
'List of all the studies for collar deployments';
