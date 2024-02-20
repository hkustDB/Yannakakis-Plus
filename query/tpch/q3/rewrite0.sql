## AggReduce Phase: 

# AggReduce0
# 1. aggView
create or replace view aggView6612446909220213367 as select c_custkey as v1, COUNT(*) as annot from customer as customer where c_mktsegment= 'BUILDING' group by c_custkey;
# 2. aggJoin
create or replace view aggJoin3067913750566530034 as select o_orderkey as v18, o_orderdate as v13, o_shippriority as v16, annot from orders as orders, aggView6612446909220213367 where orders.o_custkey=aggView6612446909220213367.v1 and o_orderdate<DATE '1995-03-15';

# AggReduce1
# 1. aggView
create or replace view aggView6543213208408442988 as select v18, v13, v16, SUM(annot) as annot from aggJoin3067913750566530034 group by v18,v13,v16;
# 2. aggJoin
create or replace view aggJoin368568443585245992 as select v18, v13, v16, annot from aggView6543213208408442988;

# AggReduce2
# 1. aggView
create or replace view aggView6497534123820958982 as select l_orderkey as v18, SUM(l_extendedprice * (1 - l_discount)) as v35 from lineitem as lineitem where l_shipdate>DATE '1995-03-15' group by l_orderkey;
# 2. aggJoin
create or replace view aggJoin961737867484448615 as select v18, v13, v16, v35 * aggJoin368568443585245992.annot as v35 from aggJoin368568443585245992 join aggView6497534123820958982 using(v18);
# Final result: 
select v18,v13,v16,v35 from aggJoin961737867484448615;

# drop view aggView6612446909220213367, aggJoin3067913750566530034, aggView6543213208408442988, aggJoin368568443585245992, aggView6497534123820958982, aggJoin961737867484448615;
