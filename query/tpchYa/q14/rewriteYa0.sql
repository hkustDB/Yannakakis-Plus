create or replace view semiUp5962970015658169837 as select l_partkey as v2, l_extendedprice as v6, l_discount as v7 from lineitem AS lineitem where (l_partkey) in (select p_partkey from part AS part) and l_shipdate>=DATE '1995-09-01' and l_shipdate<DATE '1995-10-01';
create or replace view lineitemAux29 as select v6, v7 from semiUp5962970015658169837;
create or replace view semiDown5959119306419246204 as select v2, v6, v7 from semiUp5962970015658169837 where (v7, v6) in (select v7, v6 from lineitemAux29);
create or replace view semiDown7938486788952658547 as select p_partkey as v2, p_type as v21 from part AS part where (p_partkey) in (select v2 from semiDown5959119306419246204);
create or replace view aggView4430208953480171696 as select v2, CASE WHEN v21 LIKE 'PROMO%' THEN 1 ELSE 0 END as caseCond from semiDown7938486788952658547;
create or replace view aggJoin3509511828502087823 as select v6, v7, caseCond from semiDown5959119306419246204 join aggView4430208953480171696 using(v2);
create or replace view aggView9075150849156966554 as select v7, v6, SUM( CASE WHEN caseCond = 1 THEN v6 * (1 - v7) ELSE 0.0 END) as v28, SUM(v6 * (1 - v7)) as v29, COUNT(*) as annot from aggJoin3509511828502087823 group by v7,v6;
create or replace view res as select ((100.0 * v28) / SUM(v29)) as v30 from aggView9075150849156966554;
select sum(v30) from res;
