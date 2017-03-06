-- temp

create table temp (
  perm_id varchar(20),
  species varchar(4),
  serial_num varchar(50),
  cap_date date,
  sex varchar(8),
  age varchar(10),
  mgmt_area integer,
  study_id integer,
  fate_date date
);

COPY temp (
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
FROM '/Users/mitchellgritts/Documents/telemetr/telemetr-data/animals3.csv' WITH (FORMAT csv, DELIMITER ',', HEADER true);

UPDATE animals
SET study_id = temp.study_id
FROM temp
WHERE animals.perm_id = temp.perm_id;
