create or replace view aggView4042123863377922501 as select l_orderkey as v10, COUNT(*) as annot from lineitem as l where l_commitdate<l_receiptdate group by l_orderkey;
create or replace view aggJoin3859789904190623907 as select o_orderpriority as v6, annot from orders as o, aggView4042123863377922501 where o.o_orderkey=aggView4042123863377922501.v10 and o_orderdate>=DATE '1993-07-01' and o_orderdate<DATE '1993-10-01';
create or replace view aggView4490662666973175262 as select v6, SUM(annot) as annot from aggJoin3859789904190623907 group by v6;
create or replace view aggJoin7874954939810714836 as select v6, annot from aggView4490662666973175262;
select v6,annot as v26 from aggJoin7874954939810714836;
