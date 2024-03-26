COPY (
select MIN(v2) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin1935483145017576449
) TO '/dev/null' (DELIMITER ',');
