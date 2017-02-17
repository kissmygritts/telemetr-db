SELECT serial_num, acq_time_lcl, count(serial_num)
FROM gps
GROUP BY serial_num, acq_time_lcl
HAVING count(serial_num) > 1;


-- returning the duplicates in gps
SELECT sq.serial_num, gps.id, gps.acq_time_lcl, gps.longitude, gps.latitude
FROM (
  SELECT serial_num, acq_time_lcl, count(serial_num)
  FROM gps
  GROUP BY serial_num, acq_time_lcl
  HAVING count(serial_num) > 1
) sq, gps
WHERE
  sq.serial_num = gps.serial_num AND
  sq.acq_time_lcl = gps.acq_time_lcl
;

-- QUESTION: now how can I prevent duplicates from being entered into GPS?
-- I think that this will need to be done with a trigger after each new row is entered

psuedo code:
for each new line
  if new.serial_num || new.acq_time_lcl in gps.serial_num || gps.acq_time_lcl
    delete old & import new
  end if
end for

WITH dupes AS (
  SELECT serial_num, acq_time_lcl, count(serial_num)
  FROM gps
  GROUP BY serial_num, acq_time_lcl
  HAVING count(serial_num) > 1
)

SELECT
  dupes.serial_num,
  gps.id,
  gps.acq_time_lcl,
  gps.longitude,
  gps.latitude
FROM dupes, gps
WHERE
  dupes.serial_num = gps.serial_num AND
  dupes.acq_time_lcl = gps.acq_time_lcl;

-- the code below will find duplicates to delete, however, I'm not sure which dupes it will delete?
WITH t AS (
  SELECT
    id,
    ROW_NUMBER() OVER (
      partition by serial_num, acq_time_lcl
      ORDER BY id
      ) AS rnum
  FROM gps
),

dupes AS (
  SELECT id
  FROM t
  WHERE rnum > 1
)

SELECT
    id,
    acq_time_lcl,
    serial_num
FROM gps
WHERE id IN (SELECT id FROM dupes);
