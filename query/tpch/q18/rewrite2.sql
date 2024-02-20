## AggReduce Phase: 

# AggReduce6
# 1. aggView
create or replace view aggView5424052818687706068 as select o_orderkey as v9, o_orderdate as v13, o_totalprice as v12, o_custkey as v1, COUNT(*) as annot from orders as orders group by o_orderkey,o_orderdate,o_totalprice,o_custkey;
# 2. aggJoin
create or replace view aggJoin5245378055540879437 as select v9, v1, v12, v13, annot from aggView5424052818687706068;

# AggReduce7
# 1. aggView
create or replace view aggView7316743795983184717 as select c_custkey as v1, c_name as v2, COUNT(*) as annot from customer as customer group by c_custkey,c_name;
# 2. aggJoin
create or replace view aggJoin3216077709469213477 as select v1, v2, annot from aggView7316743795983184717;

# AggReduce8
# 1. aggView
create or replace view aggView9154078558189902981 as select l_orderkey as v9, SUM(l_quantity) as v35, COUNT(*) as annot from lineitem as lineitem group by l_orderkey;
# 2. aggJoin
create or replace view aggJoin5261388178300252788 as select v9, v1, v12, v13, aggJoin5245378055540879437.annot * aggView9154078558189902981.annot as annot, v35 * aggJoin5245378055540879437.annot as v35 from aggJoin5245378055540879437 join aggView9154078558189902981 using(v9);

##Reduce Phase: 

# Reduce4
# +. SemiJoin
create or replace view semiJoinView5485883064980328391 as select v9, v1, v12, v13, annot, v35 from aggJoin5261388178300252788 where (v9) in (select v1_orderkey from view1 AS view1);

# Reduce5
# +. SemiJoin
create or replace view semiJoinView2456497099422713592 as select v1, v2, annot from aggJoin3216077709469213477 where (v1) in (select v1 from semiJoinView5485883064980328391);

## Enumerate Phase: 

# Enumerate4
# +. SemiEnumerate
create or replace view semiEnum2007608078890093366 as select v13, v12, v9, v35*semiJoinView2456497099422713592.annot as v35, v1, semiJoinView2456497099422713592.annot * semiJoinView5485883064980328391.annot as annot, v2 from semiJoinView2456497099422713592 join semiJoinView5485883064980328391 using(v1);

# Enumerate5
# +. SemiEnumerate
create or replace view semiEnum4796788792234030782 as select v13, v12, v9, v35, v1, v2 from semiEnum2007608078890093366, view1 as view1 where view1.v1_orderkey=semiEnum2007608078890093366.v9;
# Final result: 
select v1,v2,v9,v12,v13,v35 from semiEnum4796788792234030782;

# drop view aggView5424052818687706068, aggJoin5245378055540879437, aggView7316743795983184717, aggJoin3216077709469213477, aggView9154078558189902981, aggJoin5261388178300252788, semiJoinView5485883064980328391, semiJoinView2456497099422713592, semiEnum2007608078890093366, semiEnum4796788792234030782;
