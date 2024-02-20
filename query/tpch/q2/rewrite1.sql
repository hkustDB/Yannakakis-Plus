
##Reduce Phase: 

# Reduce4
# 0. Prepare
create or replace view partAux38 as select p_partkey as v1, p_mfgr as v3 from part where p_size= 15 and p_type LIKE '%BRASS';
# +. SemiJoin
create or replace view semiJoinView2836080697289992632 as select v1, v3 from partAux38 where (v1, v3) in (select p_partkey, p_mfgr from part AS part where p_size= 15 and p_type LIKE '%BRASS');

# Reduce5
# 0. Prepare
create or replace view bag1333 as select partsupp.ps_partkey as v1, supplier.s_suppkey as v10, supplier.s_name as v11, supplier.s_address as v12, supplier.s_nationkey as v13, supplier.s_phone as v14, supplier.s_acctbal as v15, supplier.s_comment as v16, partsupp.ps_availqty as v19, partsupp.ps_supplycost as v20, partsupp.ps_comment as v21, nation.n_name as v23, nation.n_regionkey as v24, nation.n_comment as v25 from supplier as supplier, partsupp as partsupp, nation as nation, view1 as view1 where supplier.s_suppkey=partsupp.ps_suppkey;
# +. SemiJoin
create or replace view semiJoinView4534987262362554105 as select v1, v11, v12, v14, v15, v16, v23, v24 from bag1333 where (v24) in (select r_regionkey from region AS region where r_name= 'EUROPE');

# Reduce6
# 0. Prepare
create or replace view bag1333Aux72 as select v1, v11, v12, v14, v15, v16, v23 from semiJoinView4534987262362554105;
# +. SemiJoin
create or replace view semiJoinView9078520456431746689 as select v1, v11, v12, v14, v15, v16, v23 from bag1333Aux72 where (v16, v15, v12, v23, v1, v14, v11) in (select v16, v15, v12, v23, v1, v14, v11 from semiJoinView4534987262362554105);

# Reduce7
# +. SemiJoin
create or replace view semiJoinView425660568791078800 as select v1, v3 from semiJoinView2836080697289992632 where (v1) in (select v1 from semiJoinView9078520456431746689);

## Enumerate Phase: 

# Enumerate1
# +. SemiEnumerate
create or replace view semiEnum6573294128554676172 as select v3, v16, v15, v12, v23, v1, v14, v11 from semiJoinView425660568791078800 join semiJoinView9078520456431746689 using(v1);
# Final result: 
select sum(distinct v15+v11+v23+v1+v3+v12+v14+v16) from semiEnum6573294128554676172;

# drop view partAux38, semiJoinView2836080697289992632, bag1333, semiJoinView4534987262362554105, bag1333Aux72, semiJoinView9078520456431746689, semiJoinView425660568791078800, semiEnum6573294128554676172;
