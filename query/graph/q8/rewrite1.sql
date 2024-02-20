
##Reduce Phase: 

# Reduce3
# +. SemiJoin
create or replace view semiJoinView1898827952071473029 as select src as v4, dst as v6 from Graph AS g3 where (dst) in (select src from Graph AS g4) and src<dst;

# Reduce4
# +. SemiJoin
create or replace view semiJoinView8639185500887169870 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select v4 from semiJoinView1898827952071473029) and src<dst;

# Reduce5
# +. SemiJoin
create or replace view semiJoinView1481735205637838634 as select v2, v4 from semiJoinView8639185500887169870 where (v2) in (select dst from Graph AS g1);

## Enumerate Phase: 

# Enumerate3
# +. SemiEnumerate
create or replace view semiEnum4593710177494382338 as select v2, src as v1, v4 from semiJoinView1481735205637838634, Graph as g1 where g1.dst=semiJoinView1481735205637838634.v2;

# Enumerate4
# +. SemiEnumerate
create or replace view semiEnum7361400640705642056 as select v2, v4, v1, v6 from semiEnum4593710177494382338 join semiJoinView1898827952071473029 using(v4);

# Enumerate5
# +. SemiEnumerate
create or replace view semiEnum8870212271726317693 as select v2, v4, dst as v8, v1, v6 from semiEnum7361400640705642056, Graph as g4 where g4.src=semiEnum7361400640705642056.v6;
# Final result: 
select sum(v1+v2+v4+v6+v8) from semiEnum8870212271726317693;

# drop view semiJoinView1898827952071473029, semiJoinView8639185500887169870, semiJoinView1481735205637838634, semiEnum4593710177494382338, semiEnum7361400640705642056, semiEnum8870212271726317693;
