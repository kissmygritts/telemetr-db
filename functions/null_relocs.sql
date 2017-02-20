CREATE OR REPLACE FUNCTION null_relocs()
RETURNS trigger AS $$
BEGIN

IF NEW.longitude IS NOT NULL AND NEW.latitude IS NOT NULL THEN
  NEW.validity_code = 2;
END IF;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER null_relocs
  AFTER INSERT
  ON relocations
  FOR EACH ROW
  EXECUTE PROCEDURE null_relocs();
