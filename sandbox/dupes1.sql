DELETE FROM tablename
WHERE id IN (SELECT id
              FROM (SELECT id,
                             ROW_NUMBER() OVER (partition BY column1, column2, column3 ORDER BY id) AS rnum
                     FROM tablename) t
              WHERE t.rnum > 1);


SELECT
  id,
  rnum
FROM (
  SELECT
    id,
    ROW_NUMBER() OVER (
      partition by serial_num, acq_time_lcl
      ORDER BY id
      ) AS rnum
  FROM gps) t
WHERE t.rnum > 1;

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
