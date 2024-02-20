## AggReduce Phase: 

# AggReduce4
# 1. aggView
create or replace view aggView869188551420260720 as select n_name as v49, n_nationkey as v13, COUNT(*) as annot from nation as nation group by n_name,n_nationkey;
# 2. aggJoin
create or replace view aggJoin6173060687081724719 as select v13, v49, annot from aggView869188551420260720;

# AggReduce5
# 1. aggView
create or replace view aggView842949314478110870 as select o_orderkey as v38, o_year as v39, COUNT(*) as annot from orderswithyear as orderswithyear group by o_orderkey,o_year;
# 2. aggJoin
create or replace view aggJoin2571626715801514875 as select v38, v39, annot from aggView842949314478110870;

# AggReduce6
# 1. aggView
create or replace view aggView7355156663842172187 as select p_partkey as v33, COUNT(*) as annot from part as part where p_name LIKE '%green%' group by p_partkey;
# 2. aggJoin
create or replace view aggJoin4140819490058374999 as select ps_partkey as v33, ps_suppkey as v10, ps_supplycost as v36, annot from partsupp as partsupp, aggView7355156663842172187 where partsupp.ps_partkey=aggView7355156663842172187.v33;

# AggReduce7
# 1. aggView
