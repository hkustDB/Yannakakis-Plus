## AggReduce Phase: 

# AggReduce9
# 1. aggView
create or replace view aggView4249184356050392039 as select o_orderkey as v9, o_orderdate as v13, o_totalprice as v12, o_custkey as v1, COUNT(*) as annot from orders as orders group by o_orderkey,o_orderdate,o_totalprice,o_custkey;
# 2. aggJoin
create or replace view aggJoin8005712871207005068 as select v9, v1, v12, v13, annot from aggView4249184356050392039;

# AggReduce10
# 1. aggView
create or replace view aggView1696014980844562635 as select c_custkey as v1, c_name as v2, COUNT(*) as annot from customer as customer group by c_custkey,c_name;
# 2. aggJoin
create or replace view aggJoin2230684608168095428 as select v1, v2, annot from aggView1696014980844562635;

# AggReduce11
# 1. aggView
create or replace view aggView345234016479944906 as select l_orderkey as v9, SUM(l_quantity) as v35, COUNT(*) as annot from lineitem as lineitem group by l_orderkey;
# 2. aggJoin
create or replace view aggJoin4732082715583870888 as select v1_orderkey as v9, v35, annot from view1 as view1, aggView345234016479944906 where view1.v1_orderkey=aggView345234016479944906.v9;

##Reduce Phase: 

# Reduce6
# +. SemiJoin
create or replace view semiJoinView5074233404742368696 as select v9, v1, v12, v13, annot from aggJoin8005712871207005068 where (v9) in (select v9 from aggJoin4732082715583870888);

# Reduce7
# +. SemiJoin
create or replace view semiJoinView2634636614200115460 as select v1, v2, annot from aggJoin2230684608168095428 where (v1) in (select v1 from semiJoinView5074233404742368696);

## Enumerate Phase: 

# Enumerate6
# +. SemiEnumerate
create or replace view semiEnum5584632287157036628 as select v9, v1, semiJoinView2634636614200115460.annot * semiJoinView5074233404742368696.annot as annot, v13, v12, v2 from semiJoinView2634636614200115460 join semiJoinView5074233404742368696 using(v1);

# Enumerate7
# +. SemiEnumerate
create or replace view semiEnum9219792588567823697 as select v13, v12, v9, v35*semiEnum5584632287157036628.annot as v35, v1, v2 from semiEnum5584632287157036628 join aggJoin4732082715583870888 using(v9);
# Final result: 
select v1,v2,v9,v12,v13,v35 from semiEnum9219792588567823697;

# drop view aggView4249184356050392039, aggJoin8005712871207005068, aggView1696014980844562635, aggJoin2230684608168095428, aggView345234016479944906, aggJoin4732082715583870888, semiJoinView5074233404742368696, semiJoinView2634636614200115460, semiEnum5584632287157036628, semiEnum9219792588567823697;
