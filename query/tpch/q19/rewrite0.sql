## AggReduce Phase: 

# AggReduce0
# 1. aggView
create or replace view aggView6407173305422013902 as select l_partkey as v17, SUM(l_extendedprice * (1 - l_discount)) as v27, COUNT(*) as annot from lineitem as lineitem where l_quantity>=21 and l_shipinstruct= 'DELIVER IN PERSON' and l_quantity<=21 + 10 and l_shipmode IN ('AIR','AIR REG') group by l_partkey;
# 2. aggJoin
create or replace view aggJoin414608325880798502 as select v27, annot from part as part, aggView6407173305422013902 where part.p_partkey=aggView6407173305422013902.v17 and p_brand= 'Brand#34' and p_size>=1 and p_container IN ('LG CASE','LG BOX','LG PACK','LG PKG') and p_size<=15;
# Final result: 
select SUM(v27) as v27 from aggJoin414608325880798502;

# drop view aggView6407173305422013902, aggJoin414608325880798502;
