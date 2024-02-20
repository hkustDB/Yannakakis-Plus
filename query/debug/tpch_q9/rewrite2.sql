## AggReduce Phase: 

# AggReduce8
# 1. aggView
create or replace view aggView4716809157617853407 as select o_orderkey as v38, o_year as v39, COUNT(*) as annot from orderswithyear as orderswithyear group by o_orderkey,o_year;
# 2. aggJoin
create or replace view aggJoin2379785257967262089 as select v38, v39, annot from aggView4716809157617853407;

# AggReduce9
# 1. aggView
create or replace view aggView7340912069323718836 as select n_name as v49, n_nationkey as v13, COUNT(*) as annot from nation as nation group by n_name,n_nationkey;
# 2. aggJoin
create or replace view aggJoin5330217666770319364 as select v13, v49, annot from aggView7340912069323718836;

# AggReduce10
# 1. aggView
create or replace view aggView4732043724985226816 as select ps_suppkey as v10, ps_partkey as v33, ps_supplycost as v36, COUNT(*) as annot from partsupp as partsupp group by ps_suppkey,ps_partkey;
# 2. aggJoin
create or replace view aggJoin7251124093552343733 as select l_orderkey as v38, l_partkey as v33, l_suppkey as v10, l_quantity as v21, l_extendedprice as v22, l_discount as v23, v36, annot from lineitem as lineitem, aggView4732043724985226816 where lineitem.l_suppkey=aggView4732043724985226816.v10 and lineitem.l_partkey=aggView4732043724985226816.v33;

# AggReduce11
# 1. aggView
create or replace view aggView5362589440688657129 as select p_partkey as v33, COUNT(*) as annot from part as part where p_name LIKE '%green%' group by p_partkey;
# 2. aggJoin
create or replace view aggJoin3832636603141861791 as select v38, v10, v21, v22, v23, v36, aggJoin7251124093552343733.annot * aggView5362589440688657129.annot as annot from aggJoin7251124093552343733 join aggView5362589440688657129 using(v33);

##Reduce Phase: 

# Reduce6
# +. SemiJoin
create or replace view semiJoinView7127819637960122641 as select v38, v10, v21, v22, v23, v36, annot from aggJoin3832636603141861791 where (v38) in (select v38 from aggJoin2379785257967262089);

# Reduce7
# +. SemiJoin
create or replace view semiJoinView5803452798468272263 as select s_suppkey as v10, s_nationkey as v13 from supplier AS supplier where (s_nationkey) in (select v13 from aggJoin5330217666770319364);

# Reduce8
# +. SemiJoin
create or replace view semiJoinView4901693878500825472 as select v38, v10, v21, v22, v23, v36, annot from semiJoinView7127819637960122641 where (v10) in (select v10 from semiJoinView5803452798468272263);

## Enumerate Phase: 

# Enumerate6
# +. SemiEnumerate
create or replace view semiEnum569851615883902843 as select annot, v13, v38 from semiJoinView4901693878500825472 join semiJoinView5803452798468272263 using(v10);

# Enumerate7
# +. SemiEnumerate
create or replace view semiEnum5257049126839595237 as select v49, semiEnum569851615883902843.annot * aggJoin5330217666770319364.annot as annot, v38 from semiEnum569851615883902843 join aggJoin5330217666770319364 using(v13);

# Enumerate8
# +. SemiEnumerate
create or replace view semiEnum4929512212617751727 as select v49, v39 from semiEnum5257049126839595237 join aggJoin2379785257967262089 using(v38);
# Final result: 
select v49,v39,SUM(v54) as v54,SUM(v55) as v55 from semiEnum4929512212617751727 group by v49, v39;

# drop view aggView4716809157617853407, aggJoin2379785257967262089, aggView7340912069323718836, aggJoin5330217666770319364, aggView4732043724985226816, aggJoin7251124093552343733, aggView5362589440688657129, aggJoin3832636603141861791, semiJoinView7127819637960122641, semiJoinView5803452798468272263, semiJoinView4901693878500825472, semiEnum569851615883902843, semiEnum5257049126839595237, semiEnum4929512212617751727;
