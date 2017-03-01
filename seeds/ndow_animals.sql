COPY animals (
  perm_id,
  species,
  sex,
  age,
  serial_num,
  cap_date,
  fate_date,
  mgmt_area,
  study_id
)
FROM '/Users/mitchellgritts/Documents/telemetr/telemetr-data/animals2.csv' WITH (FORMAT csv, DELIMITER ',', HEADER true);
