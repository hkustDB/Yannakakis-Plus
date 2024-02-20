## AggReduce Phase: 

# AggReduce4
# 1. aggView
create or replace view aggView5064990156119511497 as select l_partkey as v17, SUM(l_extendedprice) as v28, COUNT(*) as annot, l_quantity as v5 from lineitem as lineitem group by l_partkey,l_quantity;
# 2. aggJoin
create or replace view aggJoin6144520297879417388 as select v1_partkey as v17, v28, annot from view1 as view1, aggView5064990156119511497 where view1.v1_partkey=aggView5064990156119511497.v17 and v5>v1_quantity_avg;

# AggReduce5
# 1. aggView
create or replace view aggView2621535643364173400 as select p_partkey as v17, COUNT(*) as annot from part as part where p_brand= 'Brand#23' and p_container= 'MED BOX' group by p_partkey;
# 2. aggJoin
create or replace view aggJoin2867152276499224281 as select v28*aggView2621535643364173400.annot as v28, aggJoin6144520297879417388.annot * aggView2621535643364173400.annot as annot from aggJoin6144520297879417388 join aggView2621535643364173400 using(v17);
# Final result: 
select (SUM(v28) / 7.0) as v29 from aggJoin2867152276499224281;

# drop view aggView5064990156119511497, aggJoin6144520297879417388, aggView2621535643364173400, aggJoin2867152276499224281;
