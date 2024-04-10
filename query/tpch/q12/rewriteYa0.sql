create or replace view semiUp1867494261670248034 as select l_orderkey as v1, l_shipmode as v24 from lineitem AS lineitem where (l_orderkey) in (select o_orderkey from orders AS orders) and l_shipmode IN ('MAIL','SHIP') and l_receiptdate>=DATE '1994-01-01' and l_shipdate<l_commitdate and l_receiptdate<DATE '1995-01-01' and l_commitdate<l_receiptdate;
create or replace view lineitemAux81 as select v24 from semiUp1867494261670248034;
create or replace view semiDown5331359144285471390 as select v1, v24 from semiUp1867494261670248034 where (v24) in (select v24 from lineitemAux81);
create or replace view semiDown8660251006050468435 as select o_orderkey as v1, o_orderpriority as v6 from orders AS orders where (o_orderkey) in (select v1 from semiDown5331359144285471390);
create or replace view aggView7563160994421217160 as select v1, CASE WHEN (v6 IN ('1-URGENT','2-HIGH')) THEN 1 ELSE 0 END as v28, CASE WHEN (v6 NOT IN ('1-URGENT','2-HIGH')) THEN 1 ELSE 0 END as v29 from semiDown8660251006050468435;
create or replace view aggJoin8678932509089490533 as select v24, v28, v29 from semiDown5331359144285471390 join aggView7563160994421217160 using(v1);
create or replace view aggView4713884617770125085 as select v24, SUM(v28) as v28, SUM(v29) as v29, COUNT(*) as annot from aggJoin8678932509089490533 group by v24;
create or replace view res as select v24, v28, v29 from aggView4713884617770125085;
select sum(v24+v28+v29) from res;
