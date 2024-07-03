create or replace view semiUp8719795142825497393 as select l_partkey as v2, l_extendedprice as v6, l_discount as v7 from lineitem AS lineitem where (l_partkey) in (select p_partkey from part AS part) and l_shipdate>=DATE '1995-09-01' and l_shipdate<DATE '1995-10-01';
create or replace view lineitemAux80 as select v6, v7 from semiUp8719795142825497393;
create or replace view semiDown7394458441622422761 as select v2, v6, v7 from semiUp8719795142825497393 where (v6, v7) in (select v6, v7 from lineitemAux80);
create or replace view semiDown4529907454891910254 as select p_partkey as v2, p_type as v21 from part AS part where (p_partkey) in (select v2 from semiDown7394458441622422761);
create or replace view aggView5926165832693249572 as select v2, CASE WHEN v21 LIKE 'PROMO%' THEN 1 ELSE 0 END as caseCond from semiDown4529907454891910254;
create or replace view aggJoin8953861635518078713 as select v6, v7, caseCond from semiDown7394458441622422761 join aggView5926165832693249572 using(v2);
create or replace view aggView2251715129315768222 as select v7, v6, SUM( CASE WHEN caseCond = 1 THEN v6 * (1 - v7) ELSE 0.0 END) as v28, SUM(v6 * (1 - v7)) as v29, COUNT(*) as annot from aggJoin8953861635518078713 group by v7,v6;
select ((100.0 * SUM(v28)) / SUM(v29)) as v30 from aggView2251715129315768222;
