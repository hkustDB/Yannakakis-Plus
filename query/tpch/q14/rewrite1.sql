## AggReduce Phase: 

# AggReduce1
# 1. aggView
create or replace view aggView2887432999986332870 as select p_partkey as v2, CASE WHEN p_type LIKE 'PROMO%' THEN 1 ELSE 0 END as caseCond, COUNT(*) as annot from part as part group by p_partkey,caseCond;
# 2. aggJoin
create or replace view aggJoin8770331253729450325 as select l_extendedprice as v6, l_discount as v7, caseCond, annot from lineitem as lineitem, aggView2887432999986332870 where lineitem.l_partkey=aggView2887432999986332870.v2 and l_shipdate>=DATE '1995-09-01' and l_shipdate<DATE '1995-10-01';
# Final result: 
select ((100.0 * SUM( CASE WHEN caseCond = 1 THEN v6 * (1 - v7)*annot ELSE 0.0 END)) / SUM((v6 * (1 - v7))*annot)) as v30 from aggJoin8770331253729450325;

# drop view aggView2887432999986332870, aggJoin8770331253729450325;
