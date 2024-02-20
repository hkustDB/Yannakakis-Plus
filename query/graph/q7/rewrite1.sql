
##Reduce Phase: 

# Reduce2
# 0. Prepare
create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src and v10<Graph.src;
# +. SemiJoin
create or replace view semiJoinView7452091270199152743 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select v4 from g3);

# Reduce3
# 0. Prepare
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src and v8<Graph.dst;
# +. SemiJoin
create or replace view semiJoinView3302573944564344939 as select v2, v4 from semiJoinView7452091270199152743 where (v2) in (select v2 from g1);

## Enumerate Phase: 

# Enumerate2
# +. SemiEnumerate
create or replace view semiEnum8149013268621314357 as select v4, v8, v2, v7 from semiJoinView3302573944564344939 join g1 using(v2);

# Enumerate3
# +. SemiEnumerate
create or replace view semiEnum4906342011477896635 as select v10, v8, v7, v2, v4, v6 from semiEnum8149013268621314357 join g3 using(v4);
# Final result: 
select sum(v7+v2+v4+v6+v8+v10) from semiEnum4906342011477896635;

# drop view g3, semiJoinView7452091270199152743, g1, semiJoinView3302573944564344939, semiEnum8149013268621314357, semiEnum4906342011477896635;
