## AggReduce Phase: 

# AggReduce0
# 1. aggView
create or replace view aggView580246150013215480 as select o_orderkey as v1, SUM(CASE WHEN (o_orderpriority IN ('1-URGENT','2-HIGH')) THEN 1 ELSE 0 END) as v28, SUM(CASE WHEN (o_orderpriority NOT IN ('1-URGENT','2-HIGH')) THEN 1 ELSE 0 END) as v29, COUNT(*) as annot from orders as orders group by o_orderkey;
# 2. aggJoin
create or replace view aggJoin1762386369637175292 as select l_shipmode as v24, v28, v29, annot from lineitem as lineitem, aggView580246150013215480 where lineitem.l_orderkey=aggView580246150013215480.v1 and l_shipmode IN ('MAIL','SHIP') and l_receiptdate>=DATE '1994-01-01' and l_shipdate<l_commitdate and l_receiptdate<DATE '1995-01-01' and l_commitdate<l_receiptdate;

# AggReduce1
# 1. aggView
create or replace view aggView2243631482201957064 as select v24, SUM(v28) as v28, SUM(v29) as v29 from aggJoin1762386369637175292 group by v24;
# 2. aggJoin
create or replace view aggJoin625456771331787563 as select v24, v28, v29 from aggView2243631482201957064;
# Final result: 
select v24,v28,v29 from aggJoin625456771331787563;

# drop view aggView580246150013215480, aggJoin1762386369637175292, aggView2243631482201957064, aggJoin625456771331787563;
