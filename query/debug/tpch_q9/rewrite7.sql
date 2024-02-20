## AggReduce Phase: 

# AggReduce28
# 1. aggView
create or replace view aggView4481970828053313654 as select n_name as v49, n_nationkey as v13, COUNT(*) as annot from nation as nation group by n_name,n_nationkey;
# 2. aggJoin
create or replace view aggJoin1158651623229310062 as select v13, v49, annot from aggView4481970828053313654;

# AggReduce29
# 1. aggView
create or replace view aggView814459724235353271 as select o_orderkey as v38, o_year as v39, COUNT(*) as annot from orderswithyear as orderswithyear group by o_orderkey,o_year;
# 2. aggJoin
create or replace view aggJoin785000297839847063 as select v38, v39, annot from aggView814459724235353271;

# AggReduce30
# 1. aggView
create or replace view aggView2331264893779358726 as select p_partkey as v33, COUNT(*) as annot from part as part where p_name LIKE '%green%' group by p_partkey;
# 2. aggJoin
create or replace view aggJoin8174324259949314484 as select ps_partkey as v33, ps_suppkey as v10, ps_supplycost as v36, annot from partsupp as partsupp, aggView2331264893779358726 where partsupp.ps_partkey=aggView2331264893779358726.v33;

# AggReduce31
# 1. aggView
