
##Reduce Phase: 

# Reduce4
# 0. Prepare
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src and v8<Graph.dst;
# +. SemiJoin
create or replace view semiJoinView647310352648431980 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select v2 from g1);

# Reduce5
# 0. Prepare
create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src and v10<Graph.src;
# +. SemiJoin
create or replace view semiJoinView4403334660276499576 as select v4, v6, v10 from g3 where (v4) in (select v4 from semiJoinView647310352648431980);

## Enumerate Phase: 

# Enumerate4
# +. SemiEnumerate
create or replace view semiEnum7592688373536425565 as select v10, v2, v4, v6 from semiJoinView4403334660276499576 join semiJoinView647310352648431980 using(v4);

# Enumerate5
# +. SemiEnumerate
create or replace view semiEnum4893967862173772648 as select v4, v8, v10, v2, v7, v6 from semiEnum7592688373536425565 join g1 using(v2);
# Final result: 
select sum(v7+v2+v4+v6+v8+v10) from semiEnum4893967862173772648;

# drop view g1, semiJoinView647310352648431980, g3, semiJoinView4403334660276499576, semiEnum7592688373536425565, semiEnum4893967862173772648;
