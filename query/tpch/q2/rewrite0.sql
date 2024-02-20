
##Reduce Phase: 

# Reduce0
# 0. Prepare
create or replace view partAux38 as select p_partkey as v1, p_mfgr as v3 from part where p_size= 15 and p_type LIKE '%BRASS';
# +. SemiJoin
create or replace view semiJoinView4645912303769909668 as select v1, v3 from partAux38 where (v1, v3) in (select p_partkey, p_mfgr from part AS part where p_size= 15 and p_type LIKE '%BRASS');

# Reduce1
# 0. Prepare
create or replace view bag1333 as select partsupp.ps_partkey as v1, supplier.s_suppkey as v10, supplier.s_name as v11, supplier.s_address as v12, supplier.s_nationkey as v13, supplier.s_phone as v14, supplier.s_acctbal as v15, supplier.s_comment as v16, partsupp.ps_availqty as v19, partsupp.ps_supplycost as v20, partsupp.ps_comment as v21, nation.n_name as v23, nation.n_regionkey as v24, nation.n_comment as v25 from supplier as supplier, partsupp as partsupp, nation as nation, view1 as view1 where supplier.s_suppkey=partsupp.ps_suppkey;
# +. SemiJoin
create or replace view semiJoinView62711733662142537 as select v1, v11, v12, v14, v15, v16, v23, v24 from bag1333 where (v24) in (select r_regionkey from region AS region where r_name= 'EUROPE');

# Reduce2
# 0. Prepare
create or replace view bag1333Aux72 as select v1, v11, v12, v14, v15, v16, v23 from semiJoinView62711733662142537;
# +. SemiJoin
create or replace view semiJoinView6672038700085016265 as select v1, v11, v12, v14, v15, v16, v23 from bag1333Aux72 where (v16, v15, v12, v23, v1, v14, v11) in (select v16, v15, v12, v23, v1, v14, v11 from semiJoinView62711733662142537);

# Reduce3
# +. SemiJoin
create or replace view semiJoinView1806313039731409661 as select v1, v11, v12, v14, v15, v16, v23 from semiJoinView6672038700085016265 where (v1) in (select v1 from semiJoinView4645912303769909668);

## Enumerate Phase: 

# Enumerate0
# +. SemiEnumerate
create or replace view semiEnum2577393942780365958 as select v3, v16, v15, v12, v23, v1, v14, v11 from semiJoinView1806313039731409661 join semiJoinView4645912303769909668 using(v1);
# Final result: 
select sum(distinct v15+v11+v23+v1+v3+v12+v14+v16) from semiEnum2577393942780365958;

# drop view partAux38, semiJoinView4645912303769909668, bag1333, semiJoinView62711733662142537, bag1333Aux72, semiJoinView6672038700085016265, semiJoinView1806313039731409661, semiEnum2577393942780365958;
