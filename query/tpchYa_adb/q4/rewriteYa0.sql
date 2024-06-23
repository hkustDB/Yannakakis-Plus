create or replace view semiUp1270440721906700722 as select o_orderkey as v10, o_orderpriority as v6 from orders AS orders where (o_orderkey) in (select l_orderkey from lineitem AS lineitem where l_commitdate<l_receiptdate) and o_orderdate>=DATE '1993-07-01' and o_orderdate<DATE '1993-10-01';
create or replace view ordersAux23 as select v6 from semiUp1270440721906700722;
create or replace view semiDown7192659240021809163 as select v10, v6 from semiUp1270440721906700722 where (v6) in (select v6 from ordersAux23);
create or replace view semiDown468286583801842204 as select l_orderkey as v10 from lineitem AS lineitem where (l_orderkey) in (select v10 from semiDown7192659240021809163) and l_commitdate<l_receiptdate;
create or replace view aggView4419369438738576504 as select v10, COUNT(*) as annot from semiDown468286583801842204 group by v10;
create or replace view aggJoin3191862793786252257 as select v6, annot from semiDown7192659240021809163 join aggView4419369438738576504 using(v10);
create or replace view aggView3162443289546071128 as select v6, SUM(annot) as annot from aggJoin3191862793786252257 group by v6;
create or replace view res as select v6, annot as v26 from aggView3162443289546071128;
select sum(v6), sum(v26) from res;
