## AggReduce Phase: 

# AggReduce2
# 1. aggView
create or replace view aggView334169980626508436 as select v1_partkey as v17, COUNT(*) as annot, v1_quantity_avg as v27 from view1 as view1 group by v1_partkey,v1_quantity_avg;
# 2. aggJoin
create or replace view aggJoin1984651959877936367 as select p_partkey as v17, p_brand as v20, p_container as v23, v27, annot from part as part, aggView334169980626508436 where part.p_partkey=aggView334169980626508436.v17 and p_brand= 'Brand#23' and p_container= 'MED BOX';

# AggReduce3
# 1. aggView
create or replace view aggView6399768823595123274 as select v17, SUM(annot) as annot, v27 from aggJoin1984651959877936367 group by v17,v27;
# 2. aggJoin
create or replace view aggJoin642202811917353301 as select l_extendedprice as v6, annot from lineitem as lineitem, aggView6399768823595123274 where lineitem.l_partkey=aggView6399768823595123274.v17 and l_quantity>v27;
# Final result: 
select (SUM(v6*annot) / 7.0) as v29 from aggJoin642202811917353301;

# drop view aggView334169980626508436, aggJoin1984651959877936367, aggView6399768823595123274, aggJoin642202811917353301;
