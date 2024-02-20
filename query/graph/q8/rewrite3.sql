
##Reduce Phase: 

# Reduce9
# +. SemiJoin
create or replace view semiJoinView8700415100329960859 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select dst from Graph AS g1) and src<dst;

# Reduce10
# +. SemiJoin
create or replace view semiJoinView1699060879875448301 as select src as v4, dst as v6 from Graph AS g3 where (src) in (select v4 from semiJoinView8700415100329960859) and src<dst;

# Reduce11
# +. SemiJoin
create or replace view semiJoinView390634401517751241 as select src as v6, dst as v8 from Graph AS g4 where (src) in (select v6 from semiJoinView1699060879875448301);

## Enumerate Phase: 

# Enumerate9
# +. SemiEnumerate
create or replace view semiEnum4449253652575618363 as select v8, v6, v4 from semiJoinView390634401517751241 join semiJoinView1699060879875448301 using(v6);

# Enumerate10
# +. SemiEnumerate
create or replace view semiEnum6127986472249599101 as select v2, v4, v8, v6 from semiEnum4449253652575618363 join semiJoinView8700415100329960859 using(v4);

# Enumerate11
# +. SemiEnumerate
create or replace view semiEnum7512048876143086590 as select v2, v4, v8, src as v1, v6 from semiEnum6127986472249599101, Graph as g1 where g1.dst=semiEnum6127986472249599101.v2;
# Final result: 
select sum(v1+v2+v4+v6+v8) from semiEnum7512048876143086590;

# drop view semiJoinView8700415100329960859, semiJoinView1699060879875448301, semiJoinView390634401517751241, semiEnum4449253652575618363, semiEnum6127986472249599101, semiEnum7512048876143086590;
