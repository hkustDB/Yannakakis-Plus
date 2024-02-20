
##Reduce Phase: 

# Reduce0
# 0. Prepare
create or replace view supplierAux99 as select s_suppkey as v1, s_name as v2, s_address as v3, s_phone as v5 from supplier;
# +. SemiJoin
create or replace view semiJoinView2020628414606165827 as select v1, v2, v3, v5 from supplierAux99 where (v5, v2, v1, v3) in (select s_phone, s_name, s_suppkey, s_address from supplier AS supplier);

# Reduce1
# +. SemiJoin
create or replace view semiJoinView1767364537645799544 as select l_suppkey as v1, total_revenue as v9 from view1 AS view1 where (total_revenue) in (select v2_total_revenue_max from view2 AS view2);

# Reduce2
# +. SemiJoin
create or replace view semiJoinView5104789380520969608 as select v1, v9 from semiJoinView1767364537645799544 where (v1) in (select v1 from semiJoinView2020628414606165827);

## Enumerate Phase: 

# Enumerate0
# +. SemiEnumerate
create or replace view semiEnum465607314344187187 as select v3, v5, v2, v1, v9 from semiJoinView5104789380520969608 join semiJoinView2020628414606165827 using(v1);

# Enumerate1
# +. SemiEnumerate
create or replace view semiEnum1131765354041599193 as select v3, v5, v2, v1, v9 from semiEnum465607314344187187, view2 as view2 where view2.v2_total_revenue_max=semiEnum465607314344187187.v9;
# Final result: 
select sum(distinct v1+v2+v3+v5+v9) from semiEnum1131765354041599193;

# drop view supplierAux99, semiJoinView2020628414606165827, semiJoinView1767364537645799544, semiJoinView5104789380520969608, semiEnum465607314344187187, semiEnum1131765354041599193;
