## AggReduce Phase: 

# AggReduce6
# 1. aggView
create or replace view aggView4847646152890322102 as select n_nationkey as v4, n_name as v42, COUNT(*) as annot from nation as n1 where n_name= 'FRANCE' group by n_nationkey,n_name;
# 2. aggJoin
create or replace view aggJoin5187270567890105334 as select v4, v42, annot from aggView4847646152890322102;

# AggReduce7
# 1. aggView
create or replace view aggView7786242402897378041 as select n_nationkey as v36, n_name as v46, COUNT(*) as annot from nation as n2 where n_name= 'GERMANY' group by n_nationkey,n_name;
# 2. aggJoin
create or replace view aggJoin3268800984099725095 as select v36, v46, annot from aggView7786242402897378041;

##Reduce Phase: 

# Reduce15
# +. SemiJoin
create or replace view semiJoinView3897144868628683776 as select c_custkey as v33, c_nationkey as v36 from customer AS customer where (c_nationkey) in (select v36 from aggJoin3268800984099725095);

# Reduce16
# +. SemiJoin
create or replace view semiJoinView2525852636957475984 as select o_orderkey as v24, o_custkey as v33 from orders AS orders where (o_custkey) in (select v33 from semiJoinView3897144868628683776);

# Reduce17
# +. SemiJoin
create or replace view semiJoinView7505069714198919326 as select s_suppkey as v1, s_nationkey as v4 from supplier AS supplier where (s_nationkey) in (select v4 from aggJoin5187270567890105334);

# Reduce18
# +. SemiJoin
create or replace view semiJoinView7588106361071946469 as select l_orderkey as v24, l_suppkey as v1, l_extendedprice as v13, l_discount as v14, l_shipdate as v18, EXTRACT(YEAR FROM l_shipdate) as v49, (l_extendedprice * (1 - l_discount)) as v51 from lineitem AS lineitem where (l_suppkey) in (select v1 from semiJoinView7505069714198919326) and l_shipdate>=DATE '1995-01-01' and l_shipdate<=DATE '1996-12-31';

# Reduce19
# +. SemiJoin
create or replace view semiJoinView1241039557276827182 as select v24, v33 from semiJoinView2525852636957475984 where (v24) in (select v24 from semiJoinView7588106361071946469);

## Enumerate Phase: 

# Enumerate15
# +. SemiEnumerate
create or replace view semiEnum3564132072977195018 as select v51, v1, v18, v49, v33 from semiJoinView1241039557276827182 join semiJoinView7588106361071946469 using(v24);

# Enumerate16
# +. SemiEnumerate
create or replace view semiEnum3888310198812940910 as select v4, v18, v49, v33, v51 from semiEnum3564132072977195018 join semiJoinView7505069714198919326 using(v1);

# Enumerate17
# +. SemiEnumerate
create or replace view semiEnum2362471266833640696 as select annot, v18, v49, v33, v51*aggJoin5187270567890105334.annot as v51, v42 from semiEnum3888310198812940910 join aggJoin5187270567890105334 using(v4);

# Enumerate18
# +. SemiEnumerate
create or replace view semiEnum4897805720485940097 as select annot, v18, v49, v36, v51, v42 from semiEnum2362471266833640696 join semiJoinView3897144868628683776 using(v33);

# Enumerate19
# +. SemiEnumerate
create or replace view semiEnum3709333256312303053 as select v49, v46, v51*aggJoin3268800984099725095.annot as v51, v42 from semiEnum4897805720485940097 join aggJoin3268800984099725095 using(v36);
# Final result: 
select v42,v46,v49,SUM(v51) as v51 from semiEnum3709333256312303053 group by v42, v46, v49;

# drop view aggView4847646152890322102, aggJoin5187270567890105334, aggView7786242402897378041, aggJoin3268800984099725095, semiJoinView3897144868628683776, semiJoinView2525852636957475984, semiJoinView7505069714198919326, semiJoinView7588106361071946469, semiJoinView1241039557276827182, semiEnum3564132072977195018, semiEnum3888310198812940910, semiEnum2362471266833640696, semiEnum4897805720485940097, semiEnum3709333256312303053;
