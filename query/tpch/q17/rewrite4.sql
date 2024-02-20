## AggReduce Phase: 

# AggReduce8
# 1. aggView
create or replace view aggView5856768508700265607 as select l_partkey as v17, SUM(l_extendedprice) as v28, COUNT(*) as annot, l_quantity as v5 from lineitem as lineitem group by l_partkey,l_quantity;
# 2. aggJoin
create or replace view aggJoin8027017415161692440 as select v1_partkey as v17, v28, annot from view1 as view1, aggView5856768508700265607 where view1.v1_partkey=aggView5856768508700265607.v17 and v5>v1_quantity_avg;

# AggReduce9
# 1. aggView
create or replace view aggView773391490254547574 as select v17, SUM(v28) as v28, SUM(annot) as annot from aggJoin8027017415161692440 group by v17;
# 2. aggJoin
create or replace view aggJoin7750963557427272031 as select v28, annot from part as part, aggView773391490254547574 where part.p_partkey=aggView773391490254547574.v17 and p_brand= 'Brand#23' and p_container= 'MED BOX';
# Final result: 
select (SUM(v28) / 7.0) as v29 from aggJoin7750963557427272031;

# drop view aggView5856768508700265607, aggJoin8027017415161692440, aggView773391490254547574, aggJoin7750963557427272031;
