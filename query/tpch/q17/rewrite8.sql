## AggReduce Phase: 

# AggReduce16
# 1. aggView
create or replace view aggView187616138532528405 as select p_partkey as v17, COUNT(*) as annot from part as part where p_brand= 'Brand#23' and p_container= 'MED BOX' group by p_partkey;
# 2. aggJoin
create or replace view aggJoin5000626275361171263 as select l_partkey as v17, l_quantity as v5, l_extendedprice as v6, annot from lineitem as lineitem, aggView187616138532528405 where lineitem.l_partkey=aggView187616138532528405.v17;

# AggReduce17
# 1. aggView
create or replace view aggView1685341244183184310 as select v17, SUM(v6 * annot) as v28, SUM(annot) as annot, v5 from aggJoin5000626275361171263 group by v17,v5;
# 2. aggJoin
create or replace view aggJoin7397265663524180192 as select v28, annot from view1 as view1, aggView1685341244183184310 where view1.v1_partkey=aggView1685341244183184310.v17 and v5>v1_quantity_avg;
# Final result: 
select (SUM(v28) / 7.0) as v29 from aggJoin7397265663524180192;

# drop view aggView187616138532528405, aggJoin5000626275361171263, aggView1685341244183184310, aggJoin7397265663524180192;
