COPY (
select MIN(v71) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin1687600350228351754
) TO '/dev/null' (DELIMITER ',');
