create or replace view semiUp4394209815492053533 as select l_orderkey as v1, l_shipmode as v24 from lineitem AS lineitem where (l_orderkey) in (select (o_orderkey) from orders AS orders) and l_shipmode IN ('MAIL','SHIP') and l_receiptdate>=DATE '1994-01-01' and l_shipdate<l_commitdate and l_receiptdate<DATE '1995-01-01' and l_commitdate<l_receiptdate;
create or replace view lineitemAux93 as select v24 from semiUp4394209815492053533;
create or replace view semiDown8881386904403368883 as select v1, v24 from semiUp4394209815492053533 where (v24) in (select (v24) from lineitemAux93);
create or replace view semiDown2016862578593896687 as select o_orderkey as v1, o_orderpriority as v6 from orders AS orders where (o_orderkey) in (select (v1) from semiDown8881386904403368883);
create or replace view aggView5607810674385993082 as select v1, CASE WHEN (v6 IN ('1-URGENT','2-HIGH')) THEN 1 ELSE 0 END as v28, CASE WHEN (v6 NOT IN ('1-URGENT','2-HIGH')) THEN 1 ELSE 0 END as v29 from semiDown2016862578593896687;
create or replace view aggJoin1779080073002145737 as select v24, v28, v29 from semiDown8881386904403368883 join aggView5607810674385993082 using(v1);
create or replace view aggView3125027135806221971 as select v24, SUM(v28) as v28, SUM(v29) as v29, COUNT(*) as annot from aggJoin1779080073002145737 group by v24;
select v24,v28,v29 from aggView3125027135806221971;
