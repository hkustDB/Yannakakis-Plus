create or replace view semiUp1240360166020396650 as select l_orderkey as v1, l_shipmode as v24 from lineitem AS lineitem where (l_orderkey) in (select o_orderkey from orders AS orders) and l_shipmode IN ('MAIL','SHIP') and l_receiptdate>=DATE '1994-01-01' and l_shipdate<l_commitdate and l_receiptdate<DATE '1995-01-01' and l_commitdate<l_receiptdate;
create or replace view lineitemAux34 as select v24 from semiUp1240360166020396650;
create or replace view semiDown6676371847830153314 as select v1, v24 from semiUp1240360166020396650 where (v24) in (select v24 from lineitemAux34);
create or replace view semiDown2746671581703484535 as select o_orderkey as v1, o_orderpriority as v6 from orders AS orders where (o_orderkey) in (select v1 from semiDown6676371847830153314);
create or replace view aggView7860563011228245081 as select v1, CASE WHEN (v6 IN ('1-URGENT','2-HIGH')) THEN 1 ELSE 0 END as v28, CASE WHEN (v6 NOT IN ('1-URGENT','2-HIGH')) THEN 1 ELSE 0 END as v29 from semiDown2746671581703484535;
create or replace view aggJoin6906531684821022588 as select v24, v28, v29 from semiDown6676371847830153314 join aggView7860563011228245081 using(v1);
create or replace view aggView3459829077104543710 as select v24, SUM(v28) as v28, SUM(v29) as v29, COUNT(*) as annot from aggJoin6906531684821022588 group by v24,v28,v29;
select v24,v28,v29 from aggView3459829077104543710;
