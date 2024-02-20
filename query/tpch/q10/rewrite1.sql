## AggReduce Phase: 

# AggReduce4
# 1. aggView
create or replace view aggView467153901981469306 as select n_name as v35, n_nationkey as v4, COUNT(*) as annot from nation as nation group by n_name,n_nationkey;
# 2. aggJoin
create or replace view aggJoin1100764840870688429 as select v4, v35, annot from aggView467153901981469306;

# AggReduce5
# 1. aggView
create or replace view aggView6050873926251238635 as select c_address as v3, c_custkey as v1, c_comment as v8, c_name as v2, c_phone as v5, c_acctbal as v6, c_nationkey as v4, COUNT(*) as annot from customer as customer group by c_address,c_custkey,c_comment,c_name,c_phone,c_acctbal,c_nationkey;
# 2. aggJoin
create or replace view aggJoin365390225612207564 as select v1, v2, v3, v4, v5, v6, v8, annot from aggView6050873926251238635;

# AggReduce6
# 1. aggView
create or replace view aggView4228474920434645388 as select l_orderkey as v18, SUM(l_extendedprice * (1 - l_discount)) as v39, COUNT(*) as annot from lineitem as lineitem where l_returnflag= 'R' group by l_orderkey;
# 2. aggJoin
create or replace view aggJoin3428842383675628291 as select o_custkey as v1, v39, annot from orders as orders, aggView4228474920434645388 where orders.o_orderkey=aggView4228474920434645388.v18 and o_orderdate>=DATE '1993-10-01' and o_orderdate<DATE '1994-01-01';

# AggReduce7
# 1. aggView
create or replace view aggView3192805011616374618 as select v1, SUM(v39) as v39, SUM(annot) as annot from aggJoin3428842383675628291 group by v1;
# 2. aggJoin
create or replace view aggJoin4406884460742321814 as select v1, v2, v3, v4, v5, v6, v8, aggJoin365390225612207564.annot * aggView3192805011616374618.annot as annot, v39 * aggJoin365390225612207564.annot as v39 from aggJoin365390225612207564 join aggView3192805011616374618 using(v1);

##Reduce Phase: 

# Reduce1
# +. SemiJoin
create or replace view semiJoinView9061640866870313354 as select v1, v2, v3, v4, v5, v6, v8, annot, v39 from aggJoin4406884460742321814 where (v4) in (select v4 from aggJoin1100764840870688429);

## Enumerate Phase: 

# Enumerate1
# +. SemiEnumerate
create or replace view semiEnum6627193988147966526 as select v39*aggJoin1100764840870688429.annot as v39, v3, v1, v8, v2, v5, v6, v35 from semiJoinView9061640866870313354 join aggJoin1100764840870688429 using(v4);
# Final result: 
select v1,v2,v6,v5,v35,v3,v8,SUM(v39) as v39 from semiEnum6627193988147966526 group by v1, v2, v6, v5, v35, v3, v8;

# drop view aggView467153901981469306, aggJoin1100764840870688429, aggView6050873926251238635, aggJoin365390225612207564, aggView4228474920434645388, aggJoin3428842383675628291, aggView3192805011616374618, aggJoin4406884460742321814, semiJoinView9061640866870313354, semiEnum6627193988147966526;
