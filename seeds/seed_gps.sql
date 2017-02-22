COPY gps (
  serial_num,
  acq_time_lcl,
  longitude,
  latitude,
  activity,
  temperature,
  fixtype
)
FROM '/Users/mitchellgritts/Documents/telemetr/telemetr-data/device_030681_test.csv'
WITH (FORMAT csv, DELIMITER ',', HEADER true);

COPY gps (
  serial_num,
  acq_time_lcl,
  longitude,
  latitude,
  activity,
  temperature,
  fixtype,
  hdop,
  pdop,
  n_sats,
  gps_volts
)
FROM '/Users/mitchellgritts/Documents/telemetr/telemetr-data/gps.csv'
WITH (FORMAT csv, DELIMITER ',', HEADER true);
