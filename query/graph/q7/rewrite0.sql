
##Reduce Phase: 

# Reduce0
# 0. Prepare
create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src and v10<Graph.src;
# +. SemiJoin
create or replace view semiJoinView3068765938137427722 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select v4 from g3);

# Reduce1
# 0. Prepare
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src and v8<Graph.dst;
# +. SemiJoin
create or replace view semiJoinView2355863502664792227 as select v7, v2, v8 from g1 where (v2) in (select v2 from semiJoinView3068765938137427722);

## Enumerate Phase: 

# Enumerate0
# +. SemiEnumerate
create or replace view semiEnum5928695345802161220 as select v8, v2, v4, v7 from semiJoinView2355863502664792227 join semiJoinView3068765938137427722 using(v2);

# Enumerate1
# +. SemiEnumerate
create or replace view semiEnum985482808552247386 as select v10, v8, v7, v2, v4, v6 from semiEnum5928695345802161220 join g3 using(v4);
# Final result: 
select sum(v7+v2+v4+v6+v8+v10) from semiEnum985482808552247386;

# drop view g3, semiJoinView3068765938137427722, g1, semiJoinView2355863502664792227, semiEnum5928695345802161220, semiEnum985482808552247386;
