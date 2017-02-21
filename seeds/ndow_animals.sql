COPY animals (
  perm_id,
  species,
  sex,
  age,
  serial_num,
  cap_date,
  fate_date
)
FROM '/Users/mitchellgritts/Documents/telemetr/telemetr-data/animals2.csv' WITH (FORMAT csv, DELIMITER ',', HEADER true);
