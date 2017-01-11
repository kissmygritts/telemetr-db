CREATE TRIGGER tr_captures_deployments
  AFTER INSERT
  ON captures
  FOR EACH ROW
  EXECUTE PROCEDURE parse_captures();
