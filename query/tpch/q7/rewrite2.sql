## AggReduce Phase: 

# AggReduce4
# 1. aggView
create or replace view aggView3223182087256733758 as select n_nationkey as v4, n_name as v42, COUNT(*) as annot from nation as n1 where n_name= 'FRANCE' group by n_nationkey,n_name;
# 2. aggJoin
create or replace view aggJoin2262308752884047783 as select v4, v42, annot from aggView3223182087256733758;

# AggReduce5
# 1. aggView
create or replace view aggView7679061623612894520 as select n_nationkey as v36, n_name as v46, COUNT(*) as annot from nation as n2 where n_name= 'GERMANY' group by n_nationkey,n_name;
# 2. aggJoin
create or replace view aggJoin2038812878033114812 as select v36, v46, annot from aggView7679061623612894520;

##Reduce Phase: 

# Reduce10
# +. SemiJoin
create or replace view semiJoinView147590291214913294 as select s_suppkey as v1, s_nationkey as v4 from supplier AS supplier where (s_nationkey) in (select v4 from aggJoin2262308752884047783);

# Reduce11
# +. SemiJoin
create or replace view semiJoinView8258401241489489840 as select c_custkey as v33, c_nationkey as v36 from customer AS customer where (c_nationkey) in (select v36 from aggJoin2038812878033114812);

# Reduce12
# +. SemiJoin
create or replace view semiJoinView2393257584797075885 as select l_orderkey as v24, l_suppkey as v1, l_extendedprice as v13, l_discount as v14, l_shipdate as v18, EXTRACT(YEAR FROM l_shipdate) as v49, (l_extendedprice * (1 - l_discount)) as v51 from lineitem AS lineitem where (l_suppkey) in (select v1 from semiJoinView147590291214913294) and l_shipdate>=DATE '1995-01-01' and l_shipdate<=DATE '1996-12-31';

# Reduce13
# +. SemiJoin
create or replace view semiJoinView7228749088429710344 as select o_orderkey as v24, o_custkey as v33 from orders AS orders where (o_custkey) in (select v33 from semiJoinView8258401241489489840);

# Reduce14
# +. SemiJoin
create or replace view semiJoinView1860586220933525576 as select v24, v1, v13, v14, v18, v49, v51 from semiJoinView2393257584797075885 where (v24) in (select v24 from semiJoinView7228749088429710344);

## Enumerate Phase: 

# Enumerate10
# +. SemiEnumerate
create or replace view semiEnum2479727632659479278 as select v51, v1, v18, v49, v33 from semiJoinView1860586220933525576 join semiJoinView7228749088429710344 using(v24);

# Enumerate11
# +. SemiEnumerate
create or replace view semiEnum4516345642961525760 as select v18, v49, v36, v51, v1 from semiEnum2479727632659479278 join semiJoinView8258401241489489840 using(v33);

# Enumerate12
# +. SemiEnumerate
create or replace view semiEnum6581972546312106850 as select v4, v18, v49, v36, v51 from semiEnum4516345642961525760 join semiJoinView147590291214913294 using(v1);

# Enumerate13
# +. SemiEnumerate
create or replace view semiEnum8386112097682720274 as select v4, annot, v18, v49, v46, v51*aggJoin2038812878033114812.annot as v51 from semiEnum6581972546312106850 join aggJoin2038812878033114812 using(v36);

# Enumerate14
# +. SemiEnumerate
create or replace view semiEnum1507687470823516276 as select v49, v46, v51*aggJoin2262308752884047783.annot as v51, v42 from semiEnum8386112097682720274 join aggJoin2262308752884047783 using(v4);
# Final result: 
select v42,v46,v49,SUM(v51) as v51 from semiEnum1507687470823516276 group by v42, v46, v49;

# drop view aggView3223182087256733758, aggJoin2262308752884047783, aggView7679061623612894520, aggJoin2038812878033114812, semiJoinView147590291214913294, semiJoinView8258401241489489840, semiJoinView2393257584797075885, semiJoinView7228749088429710344, semiJoinView1860586220933525576, semiEnum2479727632659479278, semiEnum4516345642961525760, semiEnum6581972546312106850, semiEnum8386112097682720274, semiEnum1507687470823516276;
