
##Reduce Phase: 

# Reduce0
# 0. Prepare
create or replace view bag1626 as select partsupp.ps_partkey as v1, partsupp.ps_suppkey as v2, partsupp.ps_availqty as v3, partsupp.ps_supplycost as v4, partsupp.ps_comment as v5 from partsupp as partsupp, view1 as view1 where partsupp.ps_partkey=view1.v1_partkey;
create or replace view bag1626Aux49 as select v2, v3 from bag1626;

# Reduce1
# 2. minView
create or replace view minView699021021461740049 as select min(v2_quantity_sum) as mfR8830028062185670953 from view2;
# 3. joinView
create or replace view joinView4535743956574597114 as select v2 from bag1626Aux49, minView699021021461740049 where v3>mfR8830028062185670953;
# Final result: 
select sum(distinct v2) from joinView4535743956574597114;

# drop view bag1626, bag1626Aux49, minView699021021461740049, joinView4535743956574597114;
