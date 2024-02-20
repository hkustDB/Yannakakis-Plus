## AggReduce Phase: 

# AggReduce3
# 1. aggView
create or replace view aggView4759587749707835957 as select o_orderkey as v9, o_orderdate as v13, o_totalprice as v12, o_custkey as v1, COUNT(*) as annot from orders as orders group by o_orderkey,o_orderdate,o_totalprice,o_custkey;
# 2. aggJoin
create or replace view aggJoin6669459239407717308 as select v9, v1, v12, v13, annot from aggView4759587749707835957;

# AggReduce4
# 1. aggView
create or replace view aggView5751371039008837660 as select c_custkey as v1, c_name as v2, COUNT(*) as annot from customer as customer group by c_custkey,c_name;
# 2. aggJoin
create or replace view aggJoin4202340015454040501 as select v1, v2, annot from aggView5751371039008837660;

# AggReduce5
# 1. aggView
create or replace view aggView601315962536813921 as select l_orderkey as v9, SUM(l_quantity) as v35, COUNT(*) as annot from lineitem as lineitem group by l_orderkey;
# 2. aggJoin
create or replace view aggJoin2445868063648165603 as select v1_orderkey as v9, v35, annot from view1 as view1, aggView601315962536813921 where view1.v1_orderkey=aggView601315962536813921.v9;

##Reduce Phase: 

# Reduce2
# +. SemiJoin
create or replace view semiJoinView7025389776431746319 as select v9, v1, v12, v13, annot from aggJoin6669459239407717308 where (v9) in (select v9 from aggJoin2445868063648165603);

# Reduce3
# +. SemiJoin
create or replace view semiJoinView1137770153097044830 as select v9, v1, v12, v13, annot from semiJoinView7025389776431746319 where (v1) in (select v1 from aggJoin4202340015454040501);

## Enumerate Phase: 

# Enumerate2
# +. SemiEnumerate
create or replace view semiEnum4744095591700842867 as select v13, v12, v9, v1, semiJoinView1137770153097044830.annot * aggJoin4202340015454040501.annot as annot, v2 from semiJoinView1137770153097044830 join aggJoin4202340015454040501 using(v1);

# Enumerate3
# +. SemiEnumerate
create or replace view semiEnum7187674053737147538 as select v13, v12, v9, v35*semiEnum4744095591700842867.annot as v35, v1, v2 from semiEnum4744095591700842867 join aggJoin2445868063648165603 using(v9);
# Final result: 
select v1,v2,v9,v12,v13,v35 from semiEnum7187674053737147538;

# drop view aggView4759587749707835957, aggJoin6669459239407717308, aggView5751371039008837660, aggJoin4202340015454040501, aggView601315962536813921, aggJoin2445868063648165603, semiJoinView7025389776431746319, semiJoinView1137770153097044830, semiEnum4744095591700842867, semiEnum7187674053737147538;
