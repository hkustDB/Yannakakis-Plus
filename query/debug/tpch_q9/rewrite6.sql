## AggReduce Phase: 

# AggReduce24
# 1. aggView
create or replace view aggView661158140541746401 as select o_orderkey as v38, o_year as v39, COUNT(*) as annot from orderswithyear as orderswithyear group by o_orderkey,o_year;
# 2. aggJoin
create or replace view aggJoin4457597020650387179 as select v38, v39, annot from aggView661158140541746401;

# AggReduce25
# 1. aggView
create or replace view aggView2810801474753680687 as select n_name as v49, n_nationkey as v13, COUNT(*) as annot from nation as nation group by n_name,n_nationkey;
# 2. aggJoin
create or replace view aggJoin1145310614722918051 as select v13, v49, annot from aggView2810801474753680687;

# AggReduce26
# 1. aggView
create or replace view aggView7166855921015251417 as select ps_suppkey as v10, ps_partkey as v33, ps_supplycost as v36, COUNT(*) as annot from partsupp as partsupp group by ps_suppkey,ps_partkey;
# 2. aggJoin
create or replace view aggJoin213700654806317738 as select l_orderkey as v38, l_partkey as v33, l_suppkey as v10, l_quantity as v21, l_extendedprice as v22, l_discount as v23, v36, annot from lineitem as lineitem, aggView7166855921015251417 where lineitem.l_suppkey=aggView7166855921015251417.v10 and lineitem.l_partkey=aggView7166855921015251417.v33;

# AggReduce27
# 1. aggView
create or replace view aggView8563062963694588392 as select p_partkey as v33, COUNT(*) as annot from part as part where p_name LIKE '%green%' group by p_partkey;
# 2. aggJoin
create or replace view aggJoin533391670159298056 as select v38, v10, v21, v22, v23, v36, aggJoin213700654806317738.annot * aggView8563062963694588392.annot as annot from aggJoin213700654806317738 join aggView8563062963694588392 using(v33);

##Reduce Phase: 

# Reduce18
# +. SemiJoin
create or replace view semiJoinView1746058202375832792 as select s_suppkey as v10, s_nationkey as v13 from supplier AS supplier where (s_nationkey) in (select v13 from aggJoin1145310614722918051);

# Reduce19
# +. SemiJoin
create or replace view semiJoinView1754097228428029228 as select v38, v10, v21, v22, v23, v36, annot from aggJoin533391670159298056 where (v38) in (select v38 from aggJoin4457597020650387179);

# Reduce20
# +. SemiJoin
create or replace view semiJoinView648779889002788282 as select v10, v13 from semiJoinView1746058202375832792 where (v10) in (select v10 from semiJoinView1754097228428029228);

## Enumerate Phase: 

# Enumerate18
# +. SemiEnumerate
create or replace view semiEnum6851247789236381839 as select annot, v13, v38 from semiJoinView648779889002788282 join semiJoinView1754097228428029228 using(v10);

# Enumerate19
# +. SemiEnumerate
create or replace view semiEnum5329814987559793611 as select v39, semiEnum6851247789236381839.annot * aggJoin4457597020650387179.annot as annot, v13 from semiEnum6851247789236381839 join aggJoin4457597020650387179 using(v38);

# Enumerate20
# +. SemiEnumerate
create or replace view semiEnum1658653391065584859 as select v49, v39 from semiEnum5329814987559793611 join aggJoin1145310614722918051 using(v13);
# Final result: 
select v49,v39,SUM(v54) as v54,SUM(v55) as v55 from semiEnum1658653391065584859 group by v49, v39;

# drop view aggView661158140541746401, aggJoin4457597020650387179, aggView2810801474753680687, aggJoin1145310614722918051, aggView7166855921015251417, aggJoin213700654806317738, aggView8563062963694588392, aggJoin533391670159298056, semiJoinView1746058202375832792, semiJoinView1754097228428029228, semiJoinView648779889002788282, semiEnum6851247789236381839, semiEnum5329814987559793611, semiEnum1658653391065584859;
