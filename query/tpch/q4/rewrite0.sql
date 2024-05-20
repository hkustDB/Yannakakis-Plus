create or replace view aggView6292608695713154956 as select l_orderkey as v10, COUNT(*) as annot from lineitem as lineitem where l_commitdate<l_receiptdate group by l_orderkey;
create or replace view aggJoin8244925731722005224 as select o_orderdate as v5, o_orderpriority as v6, annot from orders as orders, aggView6292608695713154956 where orders.o_orderkey=aggView6292608695713154956.v10 and o_orderdate>=DATE '1993-07-01' and o_orderdate<DATE '1993-10-01';
create or replace view aggView3055465142344818065 as select v6, SUM(annot) as annot from aggJoin8244925731722005224 group by v6;
select v6,annot as v26 from aggView3055465142344818065;
