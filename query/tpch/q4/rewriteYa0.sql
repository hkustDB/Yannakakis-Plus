create or replace view semiUp4063809490747653934 as select o_orderkey as v10, o_orderpriority as v6 from orders AS o where (o_orderkey) in (select (l_orderkey) from lineitem AS l where l_commitdate<l_receiptdate) and o_orderdate>=DATE '1993-07-01' and o_orderdate<DATE '1993-10-01';
create or replace view oAux35 as select v6 from semiUp4063809490747653934;
create or replace view semiDown4165365397746307357 as select v10, v6 from semiUp4063809490747653934 where (v6) in (select (v6) from oAux35);
create or replace view semiDown4068893688946295995 as select l_orderkey as v10 from lineitem AS l where (l_orderkey) in (select (v10) from semiDown4165365397746307357) and l_commitdate<l_receiptdate;
create or replace view aggView7573088440455495240 as select v10, COUNT(*) as annot from semiDown4068893688946295995 group by v10;
create or replace view aggJoin24390297498932066 as select v6, annot from semiDown4165365397746307357 join aggView7573088440455495240 using(v10);
create or replace view aggView5161665667024478895 as select v6, SUM(annot) as annot from aggJoin24390297498932066 group by v6;
select v6,annot as v26 from aggView5161665667024478895;
