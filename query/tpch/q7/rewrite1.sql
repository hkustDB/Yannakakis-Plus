## AggReduce Phase: 

# AggReduce2
# 1. aggView
create or replace view aggView979598453207926572 as select n_nationkey as v4, n_name as v42, COUNT(*) as annot from nation as n1 where n_name= 'FRANCE' group by n_nationkey,n_name;
# 2. aggJoin
create or replace view aggJoin3882842126505254174 as select v4, v42, annot from aggView979598453207926572;

# AggReduce3
# 1. aggView
create or replace view aggView5194011569317829256 as select n_nationkey as v36, n_name as v46, COUNT(*) as annot from nation as n2 where n_name= 'GERMANY' group by n_nationkey,n_name;
# 2. aggJoin
create or replace view aggJoin7495270782069349466 as select v36, v46, annot from aggView5194011569317829256;

##Reduce Phase: 

# Reduce5
# +. SemiJoin
create or replace view semiJoinView7267875764185563378 as select s_suppkey as v1, s_nationkey as v4 from supplier AS supplier where (s_nationkey) in (select v4 from aggJoin3882842126505254174);

# Reduce6
# +. SemiJoin
create or replace view semiJoinView6788217861991155936 as select l_orderkey as v24, l_suppkey as v1, l_extendedprice as v13, l_discount as v14, l_shipdate as v18, EXTRACT(YEAR FROM l_shipdate) as v49, (l_extendedprice * (1 - l_discount)) as v51 from lineitem AS lineitem where (l_suppkey) in (select v1 from semiJoinView7267875764185563378) and l_shipdate>=DATE '1995-01-01' and l_shipdate<=DATE '1996-12-31';

# Reduce7
# +. SemiJoin
create or replace view semiJoinView5611730510345144567 as select o_orderkey as v24, o_custkey as v33 from orders AS orders where (o_orderkey) in (select v24 from semiJoinView6788217861991155936);

# Reduce8
# +. SemiJoin
create or replace view semiJoinView3059982158620468772 as select c_custkey as v33, c_nationkey as v36 from customer AS customer where (c_custkey) in (select v33 from semiJoinView5611730510345144567);

# Reduce9
# +. SemiJoin
create or replace view semiJoinView8167568816420215668 as select v36, v46, annot from aggJoin7495270782069349466 where (v36) in (select v36 from semiJoinView3059982158620468772);

## Enumerate Phase: 

# Enumerate5
# +. SemiEnumerate
create or replace view semiEnum2330189444268594923 as select annot, v33, v46 from semiJoinView8167568816420215668 join semiJoinView3059982158620468772 using(v36);

# Enumerate6
# +. SemiEnumerate
create or replace view semiEnum5138658727809114077 as select annot, v24, v46 from semiEnum2330189444268594923 join semiJoinView5611730510345144567 using(v33);

# Enumerate7
# +. SemiEnumerate
create or replace view semiEnum2876852808919630494 as select annot, v51*semiEnum5138658727809114077.annot as v51, v1, v18, v49, v46 from semiEnum5138658727809114077 join semiJoinView6788217861991155936 using(v24);

# Enumerate8
# +. SemiEnumerate
create or replace view semiEnum1198218257962052085 as select v4, annot, v18, v49, v46, v51 from semiEnum2876852808919630494 join semiJoinView7267875764185563378 using(v1);

# Enumerate9
# +. SemiEnumerate
create or replace view semiEnum2721668924747000234 as select v49, v46, v51*aggJoin3882842126505254174.annot as v51, v42 from semiEnum1198218257962052085 join aggJoin3882842126505254174 using(v4);
# Final result: 
select v42,v46,v49,SUM(v51) as v51 from semiEnum2721668924747000234 group by v42, v46, v49;

# drop view aggView979598453207926572, aggJoin3882842126505254174, aggView5194011569317829256, aggJoin7495270782069349466, semiJoinView7267875764185563378, semiJoinView6788217861991155936, semiJoinView5611730510345144567, semiJoinView3059982158620468772, semiJoinView8167568816420215668, semiEnum2330189444268594923, semiEnum5138658727809114077, semiEnum2876852808919630494, semiEnum1198218257962052085, semiEnum2721668924747000234;
