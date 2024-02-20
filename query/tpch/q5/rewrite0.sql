## AggReduce Phase: 

# AggReduce0
# 1. aggView
create or replace view aggView5933621052749485133 as select r_regionkey as v43, COUNT(*) as annot from region as region where r_name= 'ASIA' group by r_regionkey;
# 2. aggJoin
create or replace view aggJoin9210724077759695439 as select n_nationkey as v4, n_name as v42, annot from nation as nation, aggView5933621052749485133 where nation.n_regionkey=aggView5933621052749485133.v43;

# AggReduce1
# 1. aggView
create or replace view aggView4139743609406245823 as select s_suppkey as v20, COUNT(*) as annot from supplier as supplier group by s_suppkey;
# 2. aggJoin
create or replace view aggJoin4405287119679629454 as select l_orderkey as v18, l_extendedprice as v23, l_discount as v24, annot from lineitem as lineitem, aggView4139743609406245823 where lineitem.l_suppkey=aggView4139743609406245823.v20;

# AggReduce2
# 1. aggView
create or replace view aggView856164435341192116 as select v18, SUM((v23 * (1 - v24)) * annot) as v49, SUM(annot) as annot from aggJoin4405287119679629454 group by v18;
# 2. aggJoin
create or replace view aggJoin75088953369240520 as select o_custkey as v1, v49, annot from orders as orders, aggView856164435341192116 where orders.o_orderkey=aggView856164435341192116.v18 and o_orderdate>=DATE '1994-01-01' and o_orderdate<DATE '1995-01-01';

# AggReduce3
# 1. aggView
create or replace view aggView8933196546101899145 as select v1, SUM(v49) as v49, SUM(annot) as annot from aggJoin75088953369240520 group by v1;
# 2. aggJoin
create or replace view aggJoin7467968857884666642 as select c_nationkey as v4, v49, annot from customer as customer, aggView8933196546101899145 where customer.c_custkey=aggView8933196546101899145.v1;

# AggReduce4
# 1. aggView
create or replace view aggView4877461812733542073 as select v4, SUM(v49) as v49, SUM(annot) as annot from aggJoin7467968857884666642 group by v4;
# 2. aggJoin
create or replace view aggJoin310217338864437350 as select v42, aggJoin9210724077759695439.annot * aggView4877461812733542073.annot as annot, v49 * aggJoin9210724077759695439.annot as v49 from aggJoin9210724077759695439 join aggView4877461812733542073 using(v4);

# AggReduce5
# 1. aggView
create or replace view aggView7284520540783384303 as select v42, SUM(v49) as v49 from aggJoin310217338864437350 group by v42;
# 2. aggJoin
create or replace view aggJoin7336007903759156550 as select v42, v49 from aggView7284520540783384303;
# Final result: 
select v42,v49 from aggJoin7336007903759156550;

# drop view aggView5933621052749485133, aggJoin9210724077759695439, aggView4139743609406245823, aggJoin4405287119679629454, aggView856164435341192116, aggJoin75088953369240520, aggView8933196546101899145, aggJoin7467968857884666642, aggView4877461812733542073, aggJoin310217338864437350, aggView7284520540783384303, aggJoin7336007903759156550;
