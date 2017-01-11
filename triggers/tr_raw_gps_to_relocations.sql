CREATE TRIGGER tr_raw_gps_to_relocations
  AFTER INSERT
  ON raw_gps
  FOR EACH ROW
  EXECUTE PROCEDURE raw_gps_to_relocations();
