## AggReduce Phase: 

# AggReduce10
# 1. aggView
create or replace view aggView2357072616051302758 as select l_partkey as v17, SUM(l_extendedprice) as v28, COUNT(*) as annot, l_quantity as v5 from lineitem as lineitem group by l_partkey,l_quantity;
# 2. aggJoin
create or replace view aggJoin2635674524310203730 as select p_partkey as v17, p_brand as v20, p_container as v23, v28, v5, annot from part as part, aggView2357072616051302758 where part.p_partkey=aggView2357072616051302758.v17 and p_brand= 'Brand#23' and p_container= 'MED BOX';

# AggReduce11
# 1. aggView
create or replace view aggView330404697207777285 as select v17, SUM(v28) as v28, SUM(annot) as annot, v5 from aggJoin2635674524310203730 group by v17,v5;
# 2. aggJoin
create or replace view aggJoin5398184055448194359 as select v28, annot from view1 as view1, aggView330404697207777285 where view1.v1_partkey=aggView330404697207777285.v17 and v5>v1_quantity_avg;
# Final result: 
select (SUM(v28) / 7.0) as v29 from aggJoin5398184055448194359;

# drop view aggView2357072616051302758, aggJoin2635674524310203730, aggView330404697207777285, aggJoin5398184055448194359;
