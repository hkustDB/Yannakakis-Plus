
##Reduce Phase: 

# Reduce6
# +. SemiJoin
create or replace view semiJoinView3647753412983010572 as select src as v4, dst as v6 from Graph AS g3 where (dst) in (select src from Graph AS g4) and src<dst;

# Reduce7
# +. SemiJoin
create or replace view semiJoinView8128483482044319235 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select v4 from semiJoinView3647753412983010572) and src<dst;

# Reduce8
# +. SemiJoin
create or replace view semiJoinView5391555728603218134 as select src as v1, dst as v2 from Graph AS g1 where (dst) in (select v2 from semiJoinView8128483482044319235);

## Enumerate Phase: 

# Enumerate6
# +. SemiEnumerate
create or replace view semiEnum4101168403688709752 as select v2, v1, v4 from semiJoinView5391555728603218134 join semiJoinView8128483482044319235 using(v2);

# Enumerate7
# +. SemiEnumerate
create or replace view semiEnum2679937435627650585 as select v2, v4, v1, v6 from semiEnum4101168403688709752 join semiJoinView3647753412983010572 using(v4);

# Enumerate8
# +. SemiEnumerate
create or replace view semiEnum4703135693698479372 as select v2, v4, dst as v8, v1, v6 from semiEnum2679937435627650585, Graph as g4 where g4.src=semiEnum2679937435627650585.v6;
# Final result: 
select sum(v1+v2+v4+v6+v8) from semiEnum4703135693698479372;

# drop view semiJoinView3647753412983010572, semiJoinView8128483482044319235, semiJoinView5391555728603218134, semiEnum4101168403688709752, semiEnum2679937435627650585, semiEnum4703135693698479372;
