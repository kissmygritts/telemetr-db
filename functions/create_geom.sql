CREATE OR REPLACE FUNCTION create_geom()
RETURNS trigger AS
$BODY$
DECLARE
  thegeom geometry;
BEGIN

IF NEW.longitude IS NOT NULL AND NEW.latitude IS NOT NULL THEN
  thegeom = ST_SetSRID(ST_MakePoint(NEW.longitude, NEW.latitude), 4326);
  NEW.geom = thegeom;
END IF;

RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
COST 100;

COMMENT ON FUNCTION create_geom() IS 'Creates a geometry field with latlong SRID = 4326';

-- drop trigger
DROP TRIGGER create_geom ON relocations;

CREATE TRIGGER create_geom
  BEFORE INSERT
  ON relocations
  FOR EACH ROW
  EXECUTE PROCEDURE create_geom();

SELECT
  ST_SetSRID(ST_MakePoint(gps.longitude, gps.latitude), 4326)
FROM gps
LIMIT 10;
