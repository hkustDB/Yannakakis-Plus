create or replace view aggView8178017614549115272 as select o_orderkey as v10 from orders as orders where o_orderdate>=DATE '1993-07-01' and o_orderdate<DATE '1993-10-01';
create or replace view aggJoin4259777617586770411 as select  from lineitem as lineitem, aggView8178017614549115272 where lineitem.l_orderkey=aggView8178017614549115272.v10 and l_commitdate<l_receiptdate;
select v6,COUNT(*) as v26 from aggJoin4259777617586770411 group by v6;
