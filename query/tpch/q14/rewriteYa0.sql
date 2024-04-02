create or replace view semiUp7222978986778103082 as select l_partkey as v2, l_extendedprice as v6, l_discount as v7 from lineitem AS lineitem where (l_partkey) in (select (p_partkey) from part AS part) and l_shipdate>=DATE '1995-09-01' and l_shipdate<DATE '1995-10-01';
create or replace view semiDown7820717826749316199 as select p_partkey as v2, p_type as v21 from part AS part where (p_partkey) in (select (v2) from semiUp7222978986778103082);
create or replace view aggView6820597219722269868 as select v2, CASE WHEN v21 LIKE 'PROMO%' THEN 1 ELSE 0 END as caseCond from semiDown7820717826749316199;
create or replace view aggJoin1795932433881007754 as select v6, v7, caseCond from semiUp7222978986778103082 join aggView6820597219722269868 using(v2);
select ((100.0 * SUM( CASE WHEN caseCond = 1 THEN v6 * (1 - v7) ELSE 0.0 END)) / SUM(((v6 * (1 - v7))))) as v30 from aggJoin1795932433881007754;
