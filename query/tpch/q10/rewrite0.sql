## AggReduce Phase: 

# AggReduce0
# 1. aggView
create or replace view aggView2520526930161256229 as select n_name as v35, n_nationkey as v4, COUNT(*) as annot from nation as nation group by n_name,n_nationkey;
# 2. aggJoin
create or replace view aggJoin242838609366262611 as select v4, v35, annot from aggView2520526930161256229;

# AggReduce1
# 1. aggView
create or replace view aggView5298395833298117258 as select c_address as v3, c_custkey as v1, c_comment as v8, c_name as v2, c_phone as v5, c_acctbal as v6, c_nationkey as v4, COUNT(*) as annot from customer as customer group by c_address,c_custkey,c_comment,c_name,c_phone,c_acctbal,c_nationkey;
# 2. aggJoin
create or replace view aggJoin2709127581878206668 as select v1, v2, v3, v4, v5, v6, v8, annot from aggView5298395833298117258;

# AggReduce2
# 1. aggView
create or replace view aggView6271590848641217588 as select l_orderkey as v18, SUM(l_extendedprice * (1 - l_discount)) as v39, COUNT(*) as annot from lineitem as lineitem where l_returnflag= 'R' group by l_orderkey;
# 2. aggJoin
create or replace view aggJoin957889785942489124 as select o_custkey as v1, v39, annot from orders as orders, aggView6271590848641217588 where orders.o_orderkey=aggView6271590848641217588.v18 and o_orderdate>=DATE '1993-10-01' and o_orderdate<DATE '1994-01-01';

# AggReduce3
# 1. aggView
create or replace view aggView6389667125443996799 as select v1, SUM(v39) as v39, SUM(annot) as annot from aggJoin957889785942489124 group by v1;
# 2. aggJoin
create or replace view aggJoin792461648021296788 as select v1, v2, v3, v4, v5, v6, v8, aggJoin2709127581878206668.annot * aggView6389667125443996799.annot as annot, v39 * aggJoin2709127581878206668.annot as v39 from aggJoin2709127581878206668 join aggView6389667125443996799 using(v1);

##Reduce Phase: 

# Reduce0
# +. SemiJoin
create or replace view semiJoinView2484396835660096932 as select v4, v35, annot from aggJoin242838609366262611 where (v4) in (select v4 from aggJoin792461648021296788);

## Enumerate Phase: 

# Enumerate0
# +. SemiEnumerate
create or replace view semiEnum4718895238095492938 as select v39*semiJoinView2484396835660096932.annot as v39, v35, v3, v1, v8, v2, v5, v6 from semiJoinView2484396835660096932 join aggJoin792461648021296788 using(v4);
# Final result: 
select v1,v2,v6,v5,v35,v3,v8,SUM(v39) as v39 from semiEnum4718895238095492938 group by v1, v2, v6, v5, v35, v3, v8;

# drop view aggView2520526930161256229, aggJoin242838609366262611, aggView5298395833298117258, aggJoin2709127581878206668, aggView6271590848641217588, aggJoin957889785942489124, aggView6389667125443996799, aggJoin792461648021296788, semiJoinView2484396835660096932, semiEnum4718895238095492938;
