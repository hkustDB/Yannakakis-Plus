create or replace view aggView2780551753118159888 as select p_partkey as v2, CASE WHEN p_type LIKE 'PROMO%' THEN 1 ELSE 0 END as caseCond from part as part;
create or replace view aggJoin4900641838508704133 as select l_extendedprice as v6, l_discount as v7, l_shipdate as v11, caseCond from lineitem as lineitem, aggView2780551753118159888 where lineitem.l_partkey=aggView2780551753118159888.v2 and l_shipdate>=DATE '1995-09-01' and l_shipdate<DATE '1995-10-01';
create or replace view aggView918686844974202592 as select v7, v6, caseCond, COUNT(*) as annot from aggJoin4900641838508704133 group by v7,v6,caseCond;
select ((100.0 * SUM( CASE WHEN caseCond = 1 THEN v6 * (1 - v7)* annot ELSE 0.0 END)) / SUM(((v6 * (1 - v7)))* annot)) as v30 from aggView918686844974202592;
