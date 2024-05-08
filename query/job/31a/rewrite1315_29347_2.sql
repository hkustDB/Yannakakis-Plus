COPY (
select MIN(v61) as v61,MIN(v62) as v62,MIN(v63) as v63,MIN(v50) as v64 from aggJoin8628532554044217763
) TO '/dev/null' (DELIMITER ',');
