create or replace view aggView3868474610928703574 as select n_nationkey as v4 from nation as nation;
create or replace view aggJoin112802810028134467 as select c_custkey as v1, c_name as v2, c_address as v3, c_phone as v5, c_acctbal as v6, c_comment as v8 from customer as customer, aggView3868474610928703574 where customer.c_nationkey=aggView3868474610928703574.v4;
create or replace view aggView6268703706967259265 as select v1, COUNT(*) as annot from aggJoin112802810028134467 group by v1;
create or replace view aggJoin4109696472416595606 as select o_orderkey as v18, o_custkey as v1, o_orderdate as v13, annot from orders as orders, aggView6268703706967259265 where orders.o_custkey=aggView6268703706967259265.v1 and o_orderdate>=DATE '1993-10-01' and o_orderdate<DATE '1994-01-01';
create or replace view aggView8387086314246307770 as select v18, SUM(annot) as annot from aggJoin4109696472416595606 group by v18;
create or replace view aggJoin3845058899619047348 as select l_extendedprice as v23, l_discount as v24, annot from lineitem as lineitem, aggView8387086314246307770 where lineitem.l_orderkey=aggView8387086314246307770.v18 and l_returnflag= 'R';
select v1,v2,SUM((v23 * (1 - v24))*annot) as v39,v6,v35,v3,v5,v8 from aggJoin3845058899619047348 group by v1, v2, v6, v5, v35, v3, v8;
