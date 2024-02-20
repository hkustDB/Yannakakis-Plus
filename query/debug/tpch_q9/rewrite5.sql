## AggReduce Phase: 

# AggReduce20
# 1. aggView
create or replace view aggView5815848854131034609 as select n_name as v49, n_nationkey as v13, COUNT(*) as annot from nation as nation group by n_name,n_nationkey;
# 2. aggJoin
create or replace view aggJoin2605571257969984742 as select v13, v49, annot from aggView5815848854131034609;

# AggReduce21
# 1. aggView
create or replace view aggView8463110136917410188 as select o_orderkey as v38, o_year as v39, COUNT(*) as annot from orderswithyear as orderswithyear group by o_orderkey,o_year;
# 2. aggJoin
create or replace view aggJoin1994438338486835879 as select v38, v39, annot from aggView8463110136917410188;

# AggReduce22
# 1. aggView
create or replace view aggView3022588748832588756 as select p_partkey as v33, COUNT(*) as annot from part as part where p_name LIKE '%green%' group by p_partkey;
# 2. aggJoin
create or replace view aggJoin7588898537792548759 as select ps_partkey as v33, ps_suppkey as v10, ps_supplycost as v36, annot from partsupp as partsupp, aggView3022588748832588756 where partsupp.ps_partkey=aggView3022588748832588756.v33;

# AggReduce23
# 1. aggView
