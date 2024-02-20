## AggReduce Phase: 

# AggReduce12
# 1. aggView
create or replace view aggView9065948148548418863 as select p_partkey as v17, COUNT(*) as annot from part as part where p_brand= 'Brand#23' and p_container= 'MED BOX' group by p_partkey;
# 2. aggJoin
create or replace view aggJoin4287907213076736929 as select v1_partkey as v17, v1_quantity_avg as v27, annot from view1 as view1, aggView9065948148548418863 where view1.v1_partkey=aggView9065948148548418863.v17;

# AggReduce13
# 1. aggView
create or replace view aggView8102726616734602898 as select v17, SUM(annot) as annot, v27 from aggJoin4287907213076736929 group by v17,v27;
# 2. aggJoin
create or replace view aggJoin6567227121931260540 as select l_extendedprice as v6, annot from lineitem as lineitem, aggView8102726616734602898 where lineitem.l_partkey=aggView8102726616734602898.v17 and l_quantity>v27;
# Final result: 
select (SUM(v6*annot) / 7.0) as v29 from aggJoin6567227121931260540;

# drop view aggView9065948148548418863, aggJoin4287907213076736929, aggView8102726616734602898, aggJoin6567227121931260540;
