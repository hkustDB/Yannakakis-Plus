## AggReduce Phase: 

# AggReduce0
# 1. aggView
create or replace view aggView6640420313290562578 as select o_orderkey as v9, o_orderdate as v13, o_totalprice as v12, o_custkey as v1, COUNT(*) as annot from orders as orders group by o_orderkey,o_orderdate,o_totalprice,o_custkey;
# 2. aggJoin
create or replace view aggJoin6669758883264602249 as select v9, v1, v12, v13, annot from aggView6640420313290562578;

# AggReduce1
# 1. aggView
create or replace view aggView7220131352184028161 as select c_custkey as v1, c_name as v2, COUNT(*) as annot from customer as customer group by c_custkey,c_name;
# 2. aggJoin
create or replace view aggJoin8272777758322467733 as select v1, v2, annot from aggView7220131352184028161;

# AggReduce2
# 1. aggView
create or replace view aggView6722459112476428267 as select l_orderkey as v9, SUM(l_quantity) as v35, COUNT(*) as annot from lineitem as lineitem group by l_orderkey;
# 2. aggJoin
create or replace view aggJoin3034991476408547505 as select v9, v1, v12, v13, aggJoin6669758883264602249.annot * aggView6722459112476428267.annot as annot, v35 * aggJoin6669758883264602249.annot as v35 from aggJoin6669758883264602249 join aggView6722459112476428267 using(v9);

##Reduce Phase: 

# Reduce0
# +. SemiJoin
create or replace view semiJoinView3517750227135827488 as select v9, v1, v12, v13, annot, v35 from aggJoin3034991476408547505 where (v1) in (select v1 from aggJoin8272777758322467733);

# Reduce1
# +. SemiJoin
create or replace view semiJoinView800700489801144753 as select v9, v1, v12, v13, annot, v35 from semiJoinView3517750227135827488 where (v9) in (select v1_orderkey from view1 AS view1);

## Enumerate Phase: 

# Enumerate0
# +. SemiEnumerate
create or replace view semiEnum6799893899071452162 as select v9, v35, v1, annot, v13, v12 from semiJoinView800700489801144753, view1 as view1 where view1.v1_orderkey=semiJoinView800700489801144753.v9;

# Enumerate1
# +. SemiEnumerate
create or replace view semiEnum1005797916627703807 as select v13, v12, v9, v35*aggJoin8272777758322467733.annot as v35, v1, v2 from semiEnum6799893899071452162 join aggJoin8272777758322467733 using(v1);
# Final result: 
select v1,v2,v9,v12,v13,v35 from semiEnum1005797916627703807;

# drop view aggView6640420313290562578, aggJoin6669758883264602249, aggView7220131352184028161, aggJoin8272777758322467733, aggView6722459112476428267, aggJoin3034991476408547505, semiJoinView3517750227135827488, semiJoinView800700489801144753, semiEnum6799893899071452162, semiEnum1005797916627703807;
