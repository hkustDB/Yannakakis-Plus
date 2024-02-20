## AggReduce Phase: 

# AggReduce0
# 1. aggView
create or replace view aggView7924675040804426537 as select v1_partkey as v17, COUNT(*) as annot, v1_quantity_avg as v27 from view1 as view1 group by v1_partkey,v1_quantity_avg;
# 2. aggJoin
create or replace view aggJoin8789603477468332932 as select l_partkey as v17, l_extendedprice as v6, annot from lineitem as lineitem, aggView7924675040804426537 where lineitem.l_partkey=aggView7924675040804426537.v17 and l_quantity>v27;

# AggReduce1
# 1. aggView
create or replace view aggView2772491614977057668 as select v17, SUM(v6 * annot) as v28, SUM(annot) as annot from aggJoin8789603477468332932 group by v17;
# 2. aggJoin
create or replace view aggJoin2539197091727353057 as select v28, annot from part as part, aggView2772491614977057668 where part.p_partkey=aggView2772491614977057668.v17 and p_brand= 'Brand#23' and p_container= 'MED BOX';
# Final result: 
select (SUM(v28) / 7.0) as v29 from aggJoin2539197091727353057;

# drop view aggView7924675040804426537, aggJoin8789603477468332932, aggView2772491614977057668, aggJoin2539197091727353057;
