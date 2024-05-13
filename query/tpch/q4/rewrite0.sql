create or replace view aggView1547186937171870593 as select l_orderkey as v10, COUNT(*) as annot from lineitem as lineitem where l_commitdate<l_receiptdate group by l_orderkey;
create or replace view aggJoin4542708826398350113 as select o_orderdate as v5, o_orderpriority as v6, annot from orders as orders, aggView1547186937171870593 where orders.o_orderkey=aggView1547186937171870593.v10 and o_orderdate>=DATE '1993-07-01' and o_orderdate<DATE '1993-10-01';
create or replace view aggView6638535469391611023 as select v6, SUM(annot) as annot from aggJoin4542708826398350113;
select v6,annot as v26 from aggView6638535469391611023;
