create or replace view aggView601437977417740193 as select p_partkey as v2, CASE WHEN p_type LIKE 'PROMO%' THEN 1 ELSE 0 END as caseCond from part as part;
create or replace view aggJoin5871508978783099151 as select l_extendedprice as v6, l_discount as v7, l_shipdate as v11, caseCond from lineitem as lineitem, aggView601437977417740193 where lineitem.l_partkey=aggView601437977417740193.v2 and l_shipdate>=DATE '1995-09-01' and l_shipdate<DATE '1995-10-01';
create or replace view aggView7312764952684777714 as select v7, v6, caseCond, COUNT(*) as annot from aggJoin5871508978783099151;
select ((100.0 * SUM( CASE WHEN caseCond = 1 THEN v6 * (1 - v7)* annot ELSE 0.0 END)) / SUM(((v6 * (1 - v7)))* annot)) as v30 from aggView7312764952684777714;
