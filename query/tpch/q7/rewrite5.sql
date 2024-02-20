## AggReduce Phase: 

# AggReduce10
# 1. aggView
create or replace view aggView1913199468173423019 as select n_nationkey as v4, n_name as v42, COUNT(*) as annot from nation as n1 where n_name= 'FRANCE' group by n_nationkey,n_name;
# 2. aggJoin
create or replace view aggJoin2109146284779453184 as select v4, v42, annot from aggView1913199468173423019;

# AggReduce11
# 1. aggView
create or replace view aggView3190258857051047619 as select n_nationkey as v36, n_name as v46, COUNT(*) as annot from nation as n2 where n_name= 'GERMANY' group by n_nationkey,n_name;
# 2. aggJoin
create or replace view aggJoin6615194085182255985 as select v36, v46, annot from aggView3190258857051047619;

##Reduce Phase: 

# Reduce25
# +. SemiJoin
create or replace view semiJoinView5936162061709946184 as select c_custkey as v33, c_nationkey as v36 from customer AS customer where (c_nationkey) in (select v36 from aggJoin6615194085182255985);

# Reduce26
# +. SemiJoin
create or replace view semiJoinView3965319689371300327 as select s_suppkey as v1, s_nationkey as v4 from supplier AS supplier where (s_nationkey) in (select v4 from aggJoin2109146284779453184);

# Reduce27
# +. SemiJoin
create or replace view semiJoinView2848870478021886680 as select o_orderkey as v24, o_custkey as v33 from orders AS orders where (o_custkey) in (select v33 from semiJoinView5936162061709946184);

# Reduce28
# +. SemiJoin
create or replace view semiJoinView1968741955253761291 as select l_orderkey as v24, l_suppkey as v1, l_extendedprice as v13, l_discount as v14, l_shipdate as v18, EXTRACT(YEAR FROM l_shipdate) as v49, (l_extendedprice * (1 - l_discount)) as v51 from lineitem AS lineitem where (l_orderkey) in (select v24 from semiJoinView2848870478021886680) and l_shipdate>=DATE '1995-01-01' and l_shipdate<=DATE '1996-12-31';

# Reduce29
# +. SemiJoin
create or replace view semiJoinView3087171116885769874 as select v1, v4 from semiJoinView3965319689371300327 where (v1) in (select v1 from semiJoinView1968741955253761291);

## Enumerate Phase: 

# Enumerate25
# +. SemiEnumerate
create or replace view semiEnum1431787435975083600 as select v4, v51, v24, v18, v49 from semiJoinView3087171116885769874 join semiJoinView1968741955253761291 using(v1);

# Enumerate26
# +. SemiEnumerate
create or replace view semiEnum9101994438860909068 as select v4, v18, v49, v33, v51 from semiEnum1431787435975083600 join semiJoinView2848870478021886680 using(v24);

# Enumerate27
# +. SemiEnumerate
create or replace view semiEnum3415435494776424211 as select v4, v18, v49, v36, v51 from semiEnum9101994438860909068 join semiJoinView5936162061709946184 using(v33);

# Enumerate28
# +. SemiEnumerate
create or replace view semiEnum7727087447947902644 as select annot, v18, v49, v36, v51*aggJoin2109146284779453184.annot as v51, v42 from semiEnum3415435494776424211 join aggJoin2109146284779453184 using(v4);

# Enumerate29
# +. SemiEnumerate
create or replace view semiEnum1860623367660889441 as select v49, v46, v51*aggJoin6615194085182255985.annot as v51, v42 from semiEnum7727087447947902644 join aggJoin6615194085182255985 using(v36);
# Final result: 
select v42,v46,v49,SUM(v51) as v51 from semiEnum1860623367660889441 group by v42, v46, v49;

# drop view aggView1913199468173423019, aggJoin2109146284779453184, aggView3190258857051047619, aggJoin6615194085182255985, semiJoinView5936162061709946184, semiJoinView3965319689371300327, semiJoinView2848870478021886680, semiJoinView1968741955253761291, semiJoinView3087171116885769874, semiEnum1431787435975083600, semiEnum9101994438860909068, semiEnum3415435494776424211, semiEnum7727087447947902644, semiEnum1860623367660889441;
