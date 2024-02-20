## AggReduce Phase: 

# AggReduce12
# 1. aggView
create or replace view aggView3532110426321604981 as select n_name as v49, n_nationkey as v13, COUNT(*) as annot from nation as nation group by n_name,n_nationkey;
# 2. aggJoin
create or replace view aggJoin4069841479142716699 as select v13, v49, annot from aggView3532110426321604981;

# AggReduce13
# 1. aggView
create or replace view aggView6456888003300852180 as select o_orderkey as v38, o_year as v39, COUNT(*) as annot from orderswithyear as orderswithyear group by o_orderkey,o_year;
# 2. aggJoin
create or replace view aggJoin2034655597762872632 as select v38, v39, annot from aggView6456888003300852180;

# AggReduce14
# 1. aggView
create or replace view aggView2977807989195397465 as select p_partkey as v33, COUNT(*) as annot from part as part where p_name LIKE '%green%' group by p_partkey;
# 2. aggJoin
create or replace view aggJoin6459423103320214735 as select ps_partkey as v33, ps_suppkey as v10, ps_supplycost as v36, annot from partsupp as partsupp, aggView2977807989195397465 where partsupp.ps_partkey=aggView2977807989195397465.v33;

# AggReduce15
# 1. aggView
