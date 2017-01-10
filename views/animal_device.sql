CREATE VIEW animal_device AS
SELECT
  animals.perm_id,
  devices.serial_num,
  deployments.inservice,
  deployments.outservice,
  deployments.animal_id,
  deployments.device_id,
  deployments.id AS deployment_id
FROM (deployments
  INNER JOIN animals ON deployments.animal_id = animals.id)
  INNER JOIN devices ON deployments.device_id = devices.id
ORDER BY deployments.id DESC;
