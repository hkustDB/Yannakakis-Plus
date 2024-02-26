create or replace view aggView4042123863377922501 as select l_orderkey as v10 from lineitem as l where l_commitdate<l_receiptdate;
select o_orderpriority as v6, count(*) as v26 from orders as o where o_orderdate>=DATE '1993-07-01' and o_orderdate<DATE '1993-10-01' and (o_orderkey) in (select v10 from aggView4042123863377922501) group by v6;
