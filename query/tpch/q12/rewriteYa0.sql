create or replace view semiUp2826299404450621769 as select l_orderkey as v1, l_shipmode as v24 from lineitem AS lineitem where (l_orderkey) in (select o_orderkey from orders AS orders) and l_shipmode IN ('MAIL','SHIP') and l_receiptdate>=DATE '1994-01-01' and l_shipdate<l_commitdate and l_receiptdate<DATE '1995-01-01' and l_commitdate<l_receiptdate;
create or replace view lineitemAux34 as select v24 from semiUp2826299404450621769;
create or replace view semiDown1562401184843742809 as select v1, v24 from semiUp2826299404450621769 where (v24) in (select v24 from lineitemAux34);
create or replace view semiDown758004265435654911 as select o_orderkey as v1, o_orderpriority as v6 from orders AS orders where (o_orderkey) in (select v1 from semiDown1562401184843742809);
create or replace view aggView1220273438116412696 as select v1, CASE WHEN (v6 IN ('1-URGENT','2-HIGH')) THEN 1 ELSE 0 END as v28, CASE WHEN (v6 NOT IN ('1-URGENT','2-HIGH')) THEN 1 ELSE 0 END as v29 from semiDown758004265435654911;
create or replace view aggJoin7333098522373354435 as select v24, v28, v29 from semiDown1562401184843742809 join aggView1220273438116412696 using(v1);
create or replace view aggView6292184873608161190 as select v24, SUM(v28) as v28, SUM(v29) as v29, COUNT(*) as annot from aggJoin7333098522373354435 group by v24,v28,v29;
select v24, v28, v29 from aggView6292184873608161190;

