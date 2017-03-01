CREATE OR REPLACE FUNCTION null_relocs()
RETURNS bigint AS $$

WITH rows AS (
  UPDATE relocations
  SET validity_code = 2
  WHERE latitude IS NULL AND longitude IS NULL
  RETURNING *
)
SELECT count(*) FROM rows;

$$ LANGUAGE sql;
