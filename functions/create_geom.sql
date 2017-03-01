CREATE OR REPLACE FUNCTION create_geom()
RETURNS bigint AS $$

WITH rows AS (
  UPDATE relocations
  SET geom = ST_SetSRID(ST_MakePoint(longitude, latitude), 4326)
  WHERE validity_code = 1
  RETURNING 1
)
SELECT count(*) FROM rows;

$$ LANGUAGE sql;
