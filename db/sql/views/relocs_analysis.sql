/*
Analysis ready view of relocations for each animal. This view will only
include relocations with validity_description equal to valid positions and
position with low reliability. If the validity_code for these is edited manually
it'll be excluded in future calls to this view.
QUESTION: should I include easting and northing?
*/

CREATE VIEW relocs_analysis AS
SELECT
  animals.perm_id,
  species.species_code,
  animals.sex,
  animals.age,
  devices.serial_num,
  relocations.id AS relocs_id,
  relocations.acq_time_lcl AS acq_time,
  relocations.longitude,
  relocations.latitude,
  relocations.geom,
  relocations.validity_code,
  studies.study_name
FROM (((animals
  INNER JOIN species ON animals.species_id = species.id)
  INNER JOIN studies ON animals.study_id = studies.id)
  INNER JOIN relocations ON animals.id = relocations.animal_id)
  INNER JOIN devices ON relocations.device_id = devices.id
WHERE relocations.validity_code IN (1, 3)
ORDER BY animals.perm_id, relocations.acq_time_lcl;

COMMENT ON VIEW relocs_analysis IS 'Analysis ready view of relocations for each animal.';
