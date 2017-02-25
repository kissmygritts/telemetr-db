/*
A query to show the the deployment of each animal with the
perm_id and serial_num for that animal/deployment.
*/
CREATE VIEW animal_device AS
SELECT
  animals.perm_id,
  animals.species,
  animals.sex,
  animals.age,
  devices.serial_num,
  deployments.inservice,
  deployments.outservice,
  deployments.animal_id,
  deployments.device_id,
  deployments.id AS deployment_id
FROM (deployments
  INNER JOIN animals ON deployments.animal_id = animals.id)
  INNER JOIN devices ON deployments.device_id = devices.id;
