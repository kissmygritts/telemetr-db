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
