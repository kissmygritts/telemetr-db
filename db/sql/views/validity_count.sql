/*
shows the count and validity code and description for the relocations for each animal.
*/
CREATE VIEW relocs_validity AS
SELECT
  animals.perm_id,
  validity_codes.code,
  validity_codes.description,
  count(validity_codes.code) as n
FROM (animals
  INNER JOIN relocations ON animals.id = relocations.animal_id)
  INNER JOIN validity_codes ON relocations.validity_code = validity_codes.code
GROUP BY
  animals.perm_id,
  validity_codes.code
ORDER BY
  animals.perm_id,
  validity_codes.code;

COMMENT ON VIEW relocs_validity IS 'shows the count and validity code and description for the relocations for each animal.';
