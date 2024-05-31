create or replace view aggView6404743680324615135 as select p_partkey as v2, CASE WHEN p_type LIKE 'PROMO%' THEN 1 ELSE 0 END as caseCond from part as part;
create or replace view aggJoin8905872754654851262 as select l_extendedprice as v6, l_discount as v7, l_shipdate as v11, caseCond from lineitem as lineitem, aggView6404743680324615135 where lineitem.l_partkey=aggView6404743680324615135.v2 and l_shipdate>=DATE '1995-09-01' and l_shipdate<DATE '1995-10-01';
create or replace view aggView4216679555357358508 as select v6, v7, caseCond, COUNT(*) as annot from aggJoin8905872754654851262 group by v6,v7,caseCond;
select ((100.0 * SUM( CASE WHEN caseCond = 1 THEN v6 * (1 - v7)* annot ELSE 0.0 END)) / SUM(((v6 * (1 - v7)))* annot)) as v30 from aggView4216679555357358508;
