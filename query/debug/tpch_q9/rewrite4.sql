## AggReduce Phase: 

# AggReduce16
# 1. aggView
create or replace view aggView3168848834843743617 as select o_orderkey as v38, o_year as v39, COUNT(*) as annot from orderswithyear as orderswithyear group by o_orderkey,o_year;
# 2. aggJoin
create or replace view aggJoin2419943541849597829 as select v38, v39, annot from aggView3168848834843743617;

# AggReduce17
# 1. aggView
create or replace view aggView4318675707237077878 as select n_name as v49, n_nationkey as v13, COUNT(*) as annot from nation as nation group by n_name,n_nationkey;
# 2. aggJoin
create or replace view aggJoin6941484493977262192 as select v13, v49, annot from aggView4318675707237077878;

# AggReduce18
# 1. aggView
create or replace view aggView6814023627934859300 as select ps_suppkey as v10, ps_partkey as v33, ps_supplycost as v36, COUNT(*) as annot from partsupp as partsupp group by ps_suppkey,ps_partkey;
# 2. aggJoin
create or replace view aggJoin5872423578421542579 as select l_orderkey as v38, l_partkey as v33, l_suppkey as v10, l_quantity as v21, l_extendedprice as v22, l_discount as v23, v36, annot from lineitem as lineitem, aggView6814023627934859300 where lineitem.l_suppkey=aggView6814023627934859300.v10 and lineitem.l_partkey=aggView6814023627934859300.v33;

# AggReduce19
# 1. aggView
create or replace view aggView5524717809019378419 as select p_partkey as v33, COUNT(*) as annot from part as part where p_name LIKE '%green%' group by p_partkey;
# 2. aggJoin
create or replace view aggJoin8165512899642119876 as select v38, v10, v21, v22, v23, v36, aggJoin5872423578421542579.annot * aggView5524717809019378419.annot as annot from aggJoin5872423578421542579 join aggView5524717809019378419 using(v33);

##Reduce Phase: 

# Reduce12
# +. SemiJoin
create or replace view semiJoinView5905221157365640888 as select v38, v10, v21, v22, v23, v36, annot from aggJoin8165512899642119876 where (v38) in (select v38 from aggJoin2419943541849597829);

# Reduce13
# +. SemiJoin
create or replace view semiJoinView2981865675074412963 as select s_suppkey as v10, s_nationkey as v13 from supplier AS supplier where (s_suppkey) in (select v10 from semiJoinView5905221157365640888);

# Reduce14
# +. SemiJoin
create or replace view semiJoinView593987849342767639 as select v13, v49, annot from aggJoin6941484493977262192 where (v13) in (select v13 from semiJoinView2981865675074412963);

## Enumerate Phase: 

# Enumerate12
# +. SemiEnumerate
create or replace view semiEnum1362562347457494354 as select v49, annot, v10 from semiJoinView593987849342767639 join semiJoinView2981865675074412963 using(v13);

# Enumerate13
# +. SemiEnumerate
create or replace view semiEnum398231007020969696 as select v49, semiEnum1362562347457494354.annot * semiJoinView5905221157365640888.annot as annot, v38 from semiEnum1362562347457494354 join semiJoinView5905221157365640888 using(v10);

# Enumerate14
# +. SemiEnumerate
create or replace view semiEnum6858867844044647938 as select v49, v39 from semiEnum398231007020969696 join aggJoin2419943541849597829 using(v38);
# Final result: 
select v49,v39,SUM(v54) as v54,SUM(v55) as v55 from semiEnum6858867844044647938 group by v49, v39;

# drop view aggView3168848834843743617, aggJoin2419943541849597829, aggView4318675707237077878, aggJoin6941484493977262192, aggView6814023627934859300, aggJoin5872423578421542579, aggView5524717809019378419, aggJoin8165512899642119876, semiJoinView5905221157365640888, semiJoinView2981865675074412963, semiJoinView593987849342767639, semiEnum1362562347457494354, semiEnum398231007020969696, semiEnum6858867844044647938;
