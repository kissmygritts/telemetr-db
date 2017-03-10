CREATE TABLE deployments (
  id serial PRIMARY KEY,
  animal_id integer REFERENCES animals(id) ON DELETE CASCADE,
  device_id integer REFERENCES devices(id) ON DELETE CASCADE,
  inservice date,
  outservice date,
  attributes jsonb,
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now(),
  UNIQUE (animal_id, device_id)
);

COMMENT ON TABLE deployments IS 'Animal-device association for checking inservice and outservice dates.';
