## AggReduce Phase: 

# AggReduce1
# 1. aggView
create or replace view aggView4995194171031921825 as select p_partkey as v17, COUNT(*) as annot from part as part where p_brand= 'Brand#34' and p_size>=1 and p_container IN ('LG CASE','LG BOX','LG PACK','LG PKG') and p_size<=15 group by p_partkey;
# 2. aggJoin
create or replace view aggJoin314774794503105731 as select l_quantity as v5, l_extendedprice as v6, l_discount as v7, l_shipinstruct as v14, l_shipmode as v15, annot from lineitem as lineitem, aggView4995194171031921825 where lineitem.l_partkey=aggView4995194171031921825.v17 and l_quantity>=21 and l_shipinstruct= 'DELIVER IN PERSON' and l_quantity<=21 + 10 and l_shipmode IN ('AIR','AIR REG');
# Final result: 
select SUM((v6 * (1 - v7))) as v27 from aggJoin314774794503105731;

# drop view aggView4995194171031921825, aggJoin314774794503105731;
