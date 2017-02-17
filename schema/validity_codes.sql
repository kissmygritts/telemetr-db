CREATE TABLE validity_codes (
  code integer PRIMARY KEY,
  description varchar
);

COMMENT ON TABLE validity_codes IS 'Postion validity codes and descriptions. Each relocation will be assigned a validity code.';

INSERT INTO validity_codes (code, description)
VALUES
  (1, 'valid position'),
  (2, 'position with no coordinates'),
  (3, 'position with low reliability'),
  (4, 'impossible spike'),
  (5, 'position outside study area'),
  (6, 'impossible biological location'),
  (7, 'duplicate timestamp');
