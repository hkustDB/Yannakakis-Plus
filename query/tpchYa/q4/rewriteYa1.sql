create or replace view semiUp7912419373439991292 as select l_orderkey as v10 from lineitem AS lineitem where (l_orderkey) in (select o_orderkey from orders AS orders where o_orderdate>=DATE '1993-07-01' and o_orderdate<DATE '1993-10-01') and l_commitdate<l_receiptdate;
create or replace view semiDown2887263668698631404 as select o_orderkey as v10, o_orderpriority as v6 from orders AS orders where (o_orderkey) in (select v10 from semiUp7912419373439991292) and o_orderdate>=DATE '1993-07-01' and o_orderdate<DATE '1993-10-01';
create or replace view aggView3872906312596159532 as select v10, v6 from semiDown2887263668698631404;
create or replace view aggJoin3943257011155089313 as select v6 from semiUp7912419373439991292 join aggView3872906312596159532 using(v10);
select v6,COUNT(*) as v26 from aggJoin3943257011155089313 group by v6;
