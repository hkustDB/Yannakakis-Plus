## AggReduce Phase: 

# AggReduce0
# 1. aggView
create or replace view aggView1192645262784865054 as select l_orderkey as v10, COUNT(*) as annot from lineitem as l where l_commitdate<l_receiptdate group by l_orderkey;
# 2. aggJoin
create or replace view aggJoin7695622634499115160 as select o_orderpriority as v6, annot from orders as o, aggView1192645262784865054 where o.o_orderkey=aggView1192645262784865054.v10 and o_orderdate>=DATE '1993-07-01' and o_orderdate<DATE '1993-10-01';

# AggReduce1
# 1. aggView
create or replace view aggView4965053113537900018 as select v6, SUM(annot) as annot from aggJoin7695622634499115160 group by v6;
# 2. aggJoin
create or replace view aggJoin1568068693194616507 as select v6, annot from aggView4965053113537900018;
# Final result: 
select v6,annot as v26 from aggJoin1568068693194616507;

# drop view aggView1192645262784865054, aggJoin7695622634499115160, aggView4965053113537900018, aggJoin1568068693194616507;
