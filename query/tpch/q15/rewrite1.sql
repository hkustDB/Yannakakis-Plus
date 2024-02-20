
##Reduce Phase: 

# Reduce3
# 0. Prepare
create or replace view supplierAux99 as select s_suppkey as v1, s_name as v2, s_address as v3, s_phone as v5 from supplier;
# +. SemiJoin
create or replace view semiJoinView5786958841781430803 as select v1, v2, v3, v5 from supplierAux99 where (v5, v2, v1, v3) in (select s_phone, s_name, s_suppkey, s_address from supplier AS supplier);

# Reduce4
# +. SemiJoin
create or replace view semiJoinView8596977466765786946 as select l_suppkey as v1, total_revenue as v9 from view1 AS view1 where (total_revenue) in (select v2_total_revenue_max from view2 AS view2);

# Reduce5
# +. SemiJoin
create or replace view semiJoinView6111535338151463817 as select v1, v2, v3, v5 from semiJoinView5786958841781430803 where (v1) in (select v1 from semiJoinView8596977466765786946);

## Enumerate Phase: 

# Enumerate2
# +. SemiEnumerate
create or replace view semiEnum3691595094679877918 as select v3, v5, v2, v1, v9 from semiJoinView6111535338151463817 join semiJoinView8596977466765786946 using(v1);

# Enumerate3
# +. SemiEnumerate
create or replace view semiEnum7912402321066665961 as select v3, v5, v2, v1, v9 from semiEnum3691595094679877918, view2 as view2 where view2.v2_total_revenue_max=semiEnum3691595094679877918.v9;
# Final result: 
select sum(distinct v1+v2+v3+v5+v9) from semiEnum7912402321066665961;

# drop view supplierAux99, semiJoinView5786958841781430803, semiJoinView8596977466765786946, semiJoinView6111535338151463817, semiEnum3691595094679877918, semiEnum7912402321066665961;
