create or replace view semiUp9024266079531392596 as select l_orderkey as v10 from lineitem AS lineitem where (l_orderkey) in (select o_orderkey from orders AS orders where o_orderdate>=DATE '1993-07-01' and o_orderdate<DATE '1993-10-01') and l_commitdate<l_receiptdate;
create or replace view semiDown2788327638759223851 as select o_orderkey as v10, o_orderpriority as v6 from orders AS orders where (o_orderkey) in (select v10 from semiUp9024266079531392596) and o_orderdate>=DATE '1993-07-01' and o_orderdate<DATE '1993-10-01';
create or replace view aggView4026428204500184857 as select v10, v6 from semiDown2788327638759223851;
create or replace view aggJoin7202620482063009612 as select v6 from semiUp9024266079531392596 join aggView4026428204500184857 using(v10);
select v6, COUNT(*) as v26 from aggJoin7202620482063009612 group by v6;

