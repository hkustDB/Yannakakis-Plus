## AggReduce Phase: 

# AggReduce8
# 1. aggView
create or replace view aggView4209750442423942342 as select n_nationkey as v4, n_name as v42, COUNT(*) as annot from nation as n1 where n_name= 'FRANCE' group by n_nationkey,n_name;
# 2. aggJoin
create or replace view aggJoin8037771209367076743 as select v4, v42, annot from aggView4209750442423942342;

# AggReduce9
# 1. aggView
create or replace view aggView4159326206643106335 as select n_nationkey as v36, n_name as v46, COUNT(*) as annot from nation as n2 where n_name= 'GERMANY' group by n_nationkey,n_name;
# 2. aggJoin
create or replace view aggJoin6576333984798045277 as select v36, v46, annot from aggView4159326206643106335;

##Reduce Phase: 

# Reduce20
# +. SemiJoin
create or replace view semiJoinView2602110121094435982 as select c_custkey as v33, c_nationkey as v36 from customer AS customer where (c_nationkey) in (select v36 from aggJoin6576333984798045277);

# Reduce21
# +. SemiJoin
create or replace view semiJoinView3812260816326481633 as select o_orderkey as v24, o_custkey as v33 from orders AS orders where (o_custkey) in (select v33 from semiJoinView2602110121094435982);

# Reduce22
# +. SemiJoin
create or replace view semiJoinView2806967760015100235 as select l_orderkey as v24, l_suppkey as v1, l_extendedprice as v13, l_discount as v14, l_shipdate as v18, EXTRACT(YEAR FROM l_shipdate) as v49, (l_extendedprice * (1 - l_discount)) as v51 from lineitem AS lineitem where (l_orderkey) in (select v24 from semiJoinView3812260816326481633) and l_shipdate>=DATE '1995-01-01' and l_shipdate<=DATE '1996-12-31';

# Reduce23
# +. SemiJoin
create or replace view semiJoinView3835430458999041468 as select s_suppkey as v1, s_nationkey as v4 from supplier AS supplier where (s_suppkey) in (select v1 from semiJoinView2806967760015100235);

# Reduce24
# +. SemiJoin
create or replace view semiJoinView2948454513660023025 as select v4, v42, annot from aggJoin8037771209367076743 where (v4) in (select v4 from semiJoinView3835430458999041468);

## Enumerate Phase: 

# Enumerate20
# +. SemiEnumerate
create or replace view semiEnum2710111390749393183 as select v1, annot, v42 from semiJoinView2948454513660023025 join semiJoinView3835430458999041468 using(v4);

# Enumerate21
# +. SemiEnumerate
create or replace view semiEnum7090643315158540771 as select annot, v51*semiEnum2710111390749393183.annot as v51, v42, v24, v18, v49 from semiEnum2710111390749393183 join semiJoinView2806967760015100235 using(v1);

# Enumerate22
# +. SemiEnumerate
create or replace view semiEnum5563366053151055372 as select annot, v18, v49, v33, v51, v42 from semiEnum7090643315158540771 join semiJoinView3812260816326481633 using(v24);

# Enumerate23
# +. SemiEnumerate
create or replace view semiEnum2653477438989545476 as select annot, v18, v49, v36, v51, v42 from semiEnum5563366053151055372 join semiJoinView2602110121094435982 using(v33);

# Enumerate24
# +. SemiEnumerate
create or replace view semiEnum7301132952770095912 as select v49, v46, v51*aggJoin6576333984798045277.annot as v51, v42 from semiEnum2653477438989545476 join aggJoin6576333984798045277 using(v36);
# Final result: 
select v42,v46,v49,SUM(v51) as v51 from semiEnum7301132952770095912 group by v42, v46, v49;

# drop view aggView4209750442423942342, aggJoin8037771209367076743, aggView4159326206643106335, aggJoin6576333984798045277, semiJoinView2602110121094435982, semiJoinView3812260816326481633, semiJoinView2806967760015100235, semiJoinView3835430458999041468, semiJoinView2948454513660023025, semiEnum2710111390749393183, semiEnum7090643315158540771, semiEnum5563366053151055372, semiEnum2653477438989545476, semiEnum7301132952770095912;
