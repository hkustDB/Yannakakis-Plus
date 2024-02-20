## AggReduce Phase: 

# AggReduce0
# 1. aggView
create or replace view aggView578826304737867266 as select n_nationkey as v4, n_name as v42, COUNT(*) as annot from nation as n1 where n_name= 'FRANCE' group by n_nationkey,n_name;
# 2. aggJoin
create or replace view aggJoin8875061286031045821 as select v4, v42, annot from aggView578826304737867266;

# AggReduce1
# 1. aggView
create or replace view aggView1876999092914397664 as select n_nationkey as v36, n_name as v46, COUNT(*) as annot from nation as n2 where n_name= 'GERMANY' group by n_nationkey,n_name;
# 2. aggJoin
create or replace view aggJoin8008329451175975929 as select v36, v46, annot from aggView1876999092914397664;

##Reduce Phase: 

# Reduce0
# +. SemiJoin
create or replace view semiJoinView4426753374478685184 as select c_custkey as v33, c_nationkey as v36 from customer AS customer where (c_nationkey) in (select v36 from aggJoin8008329451175975929);

# Reduce1
# +. SemiJoin
create or replace view semiJoinView3314518217196725415 as select s_suppkey as v1, s_nationkey as v4 from supplier AS supplier where (s_nationkey) in (select v4 from aggJoin8875061286031045821);

# Reduce2
# +. SemiJoin
create or replace view semiJoinView3817043463077090214 as select l_orderkey as v24, l_suppkey as v1, l_extendedprice as v13, l_discount as v14, l_shipdate as v18, EXTRACT(YEAR FROM l_shipdate) as v49, (l_extendedprice * (1 - l_discount)) as v51 from lineitem AS lineitem where (l_suppkey) in (select v1 from semiJoinView3314518217196725415) and l_shipdate>=DATE '1995-01-01' and l_shipdate<=DATE '1996-12-31';

# Reduce3
# +. SemiJoin
create or replace view semiJoinView2990034863374076258 as select o_orderkey as v24, o_custkey as v33 from orders AS orders where (o_orderkey) in (select v24 from semiJoinView3817043463077090214);

# Reduce4
# +. SemiJoin
create or replace view semiJoinView6522929719742353788 as select v33, v36 from semiJoinView4426753374478685184 where (v33) in (select v33 from semiJoinView2990034863374076258);

## Enumerate Phase: 

# Enumerate0
# +. SemiEnumerate
create or replace view semiEnum6414867650947616219 as select v36, v24 from semiJoinView6522929719742353788 join semiJoinView2990034863374076258 using(v33);

# Enumerate1
# +. SemiEnumerate
create or replace view semiEnum1505424022498514867 as select v51, v1, v18, v49, v36 from semiEnum6414867650947616219 join semiJoinView3817043463077090214 using(v24);

# Enumerate2
# +. SemiEnumerate
create or replace view semiEnum401485965854607331 as select v4, v18, v49, v36, v51 from semiEnum1505424022498514867 join semiJoinView3314518217196725415 using(v1);

# Enumerate3
# +. SemiEnumerate
create or replace view semiEnum6227170452733343718 as select annot, v18, v49, v36, v51*aggJoin8875061286031045821.annot as v51, v42 from semiEnum401485965854607331 join aggJoin8875061286031045821 using(v4);

# Enumerate4
# +. SemiEnumerate
create or replace view semiEnum3972376490124748689 as select v49, v46, v51*aggJoin8008329451175975929.annot as v51, v42 from semiEnum6227170452733343718 join aggJoin8008329451175975929 using(v36);
# Final result: 
select v42,v46,v49,SUM(v51) as v51 from semiEnum3972376490124748689 group by v42, v46, v49;

# drop view aggView578826304737867266, aggJoin8875061286031045821, aggView1876999092914397664, aggJoin8008329451175975929, semiJoinView4426753374478685184, semiJoinView3314518217196725415, semiJoinView3817043463077090214, semiJoinView2990034863374076258, semiJoinView6522929719742353788, semiEnum6414867650947616219, semiEnum1505424022498514867, semiEnum401485965854607331, semiEnum6227170452733343718, semiEnum3972376490124748689;
