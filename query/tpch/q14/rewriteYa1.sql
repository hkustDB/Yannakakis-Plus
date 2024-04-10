create or replace view semiUp7177333605625820582 as select p_partkey as v2, p_type as v21 from part AS part where (p_partkey) in (select l_partkey from lineitem AS lineitem where l_shipdate>=DATE '1995-09-01' and l_shipdate<DATE '1995-10-01');
create or replace view semiDown3916612593589395738 as select l_partkey as v2, l_extendedprice as v6, l_discount as v7 from lineitem AS lineitem where (l_partkey) in (select v2 from semiUp7177333605625820582) and l_shipdate>=DATE '1995-09-01' and l_shipdate<DATE '1995-10-01';
create or replace view aggView4153119450768530222 as select v2, v6 * (1 - v7) as caseRes, SUM(v6 * (1 - v7)) as v29, COUNT(*) as annot from semiDown3916612593589395738 group by v2,caseRes;
create or replace view aggJoin2512438082076209224 as select v21, caseRes, v29, annot from semiUp7177333605625820582 join aggView4153119450768530222 using(v2);
create or replace view res as select ((100.0 * SUM( CASE WHEN v21 LIKE 'PROMO%' THEN caseRes * annot ELSE 0.0 END)) / SUM(v29)) as v30 from aggJoin2512438082076209224;
select sum(v30) from res;
