
##Reduce Phase: 

# Reduce0
# +. SemiJoin
create or replace view semiJoinView4845000377615541462 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select dst from Graph AS g1) and src<dst;

# Reduce1
# +. SemiJoin
create or replace view semiJoinView4276910456698811783 as select src as v4, dst as v6 from Graph AS g3 where (dst) in (select src from Graph AS g4) and src<dst;

# Reduce2
# +. SemiJoin
create or replace view semiJoinView1869866014240924493 as select v4, v6 from semiJoinView4276910456698811783 where (v4) in (select v4 from semiJoinView4845000377615541462);

## Enumerate Phase: 

# Enumerate0
# +. SemiEnumerate
create or replace view semiEnum1702090793049473394 as select v2, v6, v4 from semiJoinView1869866014240924493 join semiJoinView4845000377615541462 using(v4);

# Enumerate1
# +. SemiEnumerate
create or replace view semiEnum2737362952893432640 as select v2, v4, dst as v8, v6 from semiEnum1702090793049473394, Graph as g4 where g4.src=semiEnum1702090793049473394.v6;

# Enumerate2
# +. SemiEnumerate
create or replace view semiEnum4291688959750943923 as select v2, v4, v8, src as v1, v6 from semiEnum2737362952893432640, Graph as g1 where g1.dst=semiEnum2737362952893432640.v2;
# Final result: 
select sum(v1+v2+v4+v6+v8) from semiEnum4291688959750943923;

# drop view semiJoinView4845000377615541462, semiJoinView4276910456698811783, semiJoinView1869866014240924493, semiEnum1702090793049473394, semiEnum2737362952893432640, semiEnum4291688959750943923;
