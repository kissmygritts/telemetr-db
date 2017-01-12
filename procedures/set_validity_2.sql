UPDATE relocations
SET validity_code = 2
WHERE geom IS NULL;
