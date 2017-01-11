COPY raw_gps (
  serial_num,
  acq_time_lcl,
  longitude,
  latitude,
  altitude,
  hdop,
  temperature,
  fixtype,
  gps_volts
)
FROM '/Users/mitchellgritts/Documents/telemetr/telemetr-db/data/sgsm_01438.csv'
WITH (FORMAT csv, DELIMITER ',', HEADER true);
