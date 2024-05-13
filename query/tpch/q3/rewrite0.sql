create or replace view aggView7457964579755812160 as select c_custkey as v1 from customer as customer where c_mktsegment= 'BUILDING';
create or replace view aggJoin500894752975698070 as select o_orderkey as v18, o_orderdate as v13, o_shippriority as v16 from orders as orders, aggView7457964579755812160 where orders.o_custkey=aggView7457964579755812160.v1 and o_orderdate<DATE '1995-03-15';
create or replace view aggView5800428708963597237 as select v13, v18, v16, COUNT(*) as annot from aggJoin500894752975698070;
create or replace view aggView6636892030623986198 as select l_orderkey as v18, SUM(l_extendedprice * (1 - l_discount)) as v35 from lineitem as lineitem where l_shipdate>DATE '1995-03-15' group by l_orderkey;
create or replace view aggJoin3138382762028284359 as select v13, v18, v16, v35 * aggView5800428708963597237.annot as v35 from aggView5800428708963597237 join aggView6636892030623986198 using(v18);
select v18,v35,v13,v16 from aggJoin3138382762028284359;
