## AggReduce Phase: 

# AggReduce6
# 1. aggView
create or replace view aggView6671948576447655117 as select v1_partkey as v17, COUNT(*) as annot, v1_quantity_avg as v27 from view1 as view1 group by v1_partkey,v1_quantity_avg;
# 2. aggJoin
create or replace view aggJoin4236364484890335417 as select l_partkey as v17, l_extendedprice as v6, annot from lineitem as lineitem, aggView6671948576447655117 where lineitem.l_partkey=aggView6671948576447655117.v17 and l_quantity>v27;

# AggReduce7
# 1. aggView
create or replace view aggView460032583917274943 as select p_partkey as v17, COUNT(*) as annot from part as part where p_brand= 'Brand#23' and p_container= 'MED BOX' group by p_partkey;
# 2. aggJoin
create or replace view aggJoin3246044681697136286 as select v6, aggJoin4236364484890335417.annot * aggView460032583917274943.annot as annot from aggJoin4236364484890335417 join aggView460032583917274943 using(v17);
# Final result: 
select (SUM(v6*annot) / 7.0) as v29 from aggJoin3246044681697136286;

# drop view aggView6671948576447655117, aggJoin4236364484890335417, aggView460032583917274943, aggJoin3246044681697136286;
