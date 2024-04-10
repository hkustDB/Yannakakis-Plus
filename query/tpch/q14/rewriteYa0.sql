create or replace view semiUp1126948312844349208 as select l_partkey as v2, l_extendedprice as v6, l_discount as v7 from lineitem AS lineitem where (l_partkey) in (select p_partkey from part AS part) and l_shipdate>=DATE '1995-09-01' and l_shipdate<DATE '1995-10-01';
create or replace view semiDown2331689650460929189 as select p_partkey as v2, p_type as v21 from part AS part where (p_partkey) in (select v2 from semiUp1126948312844349208);
create or replace view aggView1758523278918917366 as select v2, CASE WHEN v21 LIKE 'PROMO%' THEN 1 ELSE 0 END as caseCond from semiDown2331689650460929189;
create or replace view aggJoin8667774451098510632 as select v6, v7, caseCond from semiUp1126948312844349208 join aggView1758523278918917366 using(v2);
create or replace view res as select ((100.0 * SUM( CASE WHEN caseCond = 1 THEN v6 * (1 - v7) ELSE 0.0 END)) / SUM(((v6 * (1 - v7))))) as v30 from aggJoin8667774451098510632;
select sum(v30) from res;
