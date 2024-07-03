SET max_parallel_workers_per_gather=72;
SET max_parallel_workers=72;
COPY (
select MIN(v44) as v44,MIN(v45) as v45,MIN(v33) as v46 from aggJoin2173771323755192498
) TO '/dev/null' DELIMITER ',' CSV;
