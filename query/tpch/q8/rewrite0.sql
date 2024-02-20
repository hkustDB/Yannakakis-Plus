## AggReduce Phase: 

# AggReduce0
# 1. aggView
create or replace view aggView315552216671802021 as select n_nationkey as v13, CASE WHEN n_name = 'BRAZIL' THEN 1 ELSE 0 END as caseCond, COUNT(*) as annot from nation as n2 group by n_nationkey,caseCond;
# 2. aggJoin
create or replace view aggJoin5804520617411050932 as select s_suppkey as v10, caseCond, annot from supplier as supplier, aggView315552216671802021 where supplier.s_nationkey=aggView315552216671802021.v13;

# AggReduce1
# 1. aggView
create or replace view aggView7905067876069582436 as select r_regionkey as v53, COUNT(*) as annot from region as region where r_name= 'AMERICA' group by r_regionkey;
# 2. aggJoin
create or replace view aggJoin9199371615373260308 as select n_nationkey as v46, annot from nation as n1, aggView7905067876069582436 where n1.n_regionkey=aggView7905067876069582436.v53;

# AggReduce2
# 1. aggView
create or replace view aggView3171564410550958206 as select v46, SUM(annot) as annot from aggJoin9199371615373260308 group by v46;
# 2. aggJoin
create or replace view aggJoin296961611387365352 as select c_custkey as v35, annot from customer as customer, aggView3171564410550958206 where customer.c_nationkey=aggView3171564410550958206.v46;

# AggReduce3
# 1. aggView
create or replace view aggView4579140973924053841 as select p_partkey as v1, COUNT(*) as annot from part as part where p_type= 'ECONOMY ANODIZED STEEL' group by p_partkey;
# 2. aggJoin
create or replace view aggJoin2693444293758552527 as select l_orderkey as v17, l_suppkey as v10, l_extendedprice as v22, l_discount as v23, annot from lineitem as lineitem, aggView4579140973924053841 where lineitem.l_partkey=aggView4579140973924053841.v1;

# AggReduce4
# 1. aggView
create or replace view aggView2204195796103890474 as select v35, SUM(annot) as annot from aggJoin296961611387365352 group by v35;
# 2. aggJoin
create or replace view aggJoin3683712083048552197 as select o_orderkey as v17, o_year as v34, annot from orderswithyear as orderswithyear, aggView2204195796103890474 where orderswithyear.o_custkey=aggView2204195796103890474.v35 and o_orderdate>=DATE '1995-01-01' and o_orderdate<=DATE '1996-12-31';

# AggReduce5
# 1. aggView
create or replace view aggView1629847542371434181 as select v10, caseCond, SUM(annot) as annot from aggJoin5804520617411050932 group by v10,caseCond;
# 2. aggJoin
create or replace view aggJoin5928983154261595364 as select v17, v22, v23, aggJoin2693444293758552527.annot * aggView1629847542371434181.annot as annot, caseCond from aggJoin2693444293758552527 join aggView1629847542371434181 using(v10);

# AggReduce6
# 1. aggView
create or replace view aggView8731602439947192096 as select v17, SUM( CASE WHEN caseCond = 1 THEN v22 * (1 - v23)*annot ELSE 0.0 END) as v64, SUM((v22 * (1 - v23)) * annot) as v65, SUM(annot) as annot from aggJoin5928983154261595364 group by v17;
# 2. aggJoin
create or replace view aggJoin6886291837160948669 as select v34, aggJoin3683712083048552197.annot * aggView8731602439947192096.annot as annot, v64 * aggJoin3683712083048552197.annot as v64, v65 * aggJoin3683712083048552197.annot as v65 from aggJoin3683712083048552197 join aggView8731602439947192096 using(v17);

# AggReduce7
# 1. aggView
create or replace view aggView8828732254706387500 as select v34, SUM(v64) as v64, SUM(v65) as v65 from aggJoin6886291837160948669 group by v34;
# 2. aggJoin
create or replace view aggJoin3196236929215021042 as select v34, v64, v65 from aggView8828732254706387500;
# Final result: 
select v34,(v64 / v65) as v66 from aggJoin3196236929215021042;

# drop view aggView315552216671802021, aggJoin5804520617411050932, aggView7905067876069582436, aggJoin9199371615373260308, aggView3171564410550958206, aggJoin296961611387365352, aggView4579140973924053841, aggJoin2693444293758552527, aggView2204195796103890474, aggJoin3683712083048552197, aggView1629847542371434181, aggJoin5928983154261595364, aggView8731602439947192096, aggJoin6886291837160948669, aggView8828732254706387500, aggJoin3196236929215021042;
