create or replace view semiUp8893496085075571159 as select o_orderkey as v10, o_orderpriority as v6 from orders AS orders where (o_orderkey) in (select l_orderkey from lineitem AS lineitem where l_commitdate<l_receiptdate) and o_orderdate>=DATE '1993-07-01' and o_orderdate<DATE '1993-10-01';
create or replace view ordersAux89 as select v6 from semiUp8893496085075571159;
create or replace view semiDown6121711308357670497 as select v10, v6 from semiUp8893496085075571159 where (v6) in (select v6 from ordersAux89);
create or replace view semiDown6519618347100851751 as select l_orderkey as v10 from lineitem AS lineitem where (l_orderkey) in (select v10 from semiDown6121711308357670497) and l_commitdate<l_receiptdate;
create or replace view aggView5381251541192446730 as select v10, COUNT(*) as annot from semiDown6519618347100851751 group by v10;
create or replace view aggJoin4779463374664180106 as select v6, annot from semiDown6121711308357670497 join aggView5381251541192446730 using(v10);
create or replace view aggView670753666900726666 as select v6, SUM(annot) as annot from aggJoin4779463374664180106 group by v6;
select v6,annot as v26 from aggView670753666900726666;
