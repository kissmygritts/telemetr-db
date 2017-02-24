CREATE TABLE devices (
  id serial PRIMARY KEY,
  serial_num varchar(50) UNIQUE,
  frequency real,
  vendor varchar(50),
  model varchar(75),
  device_type varchar(50),
  mfg_date date,
  vhf_lot varchar(50),
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now()
);

COMMENT ON TABLE devices IS 'This table is a list of all the telemetry devices owned by the agency.';
