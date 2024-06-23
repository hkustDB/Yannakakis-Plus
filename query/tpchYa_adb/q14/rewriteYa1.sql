create or replace view semiUp1729250738167113874 as select p_partkey as v2, p_type as v21 from part AS part where (p_partkey) in (select l_partkey from lineitem AS lineitem where l_shipdate>=DATE '1995-09-01' and l_shipdate<DATE '1995-10-01');
create or replace view semiDown5385992646031380013 as select l_partkey as v2, l_extendedprice as v6, l_discount as v7 from lineitem AS lineitem where (l_partkey) in (select v2 from semiUp1729250738167113874) and l_shipdate>=DATE '1995-09-01' and l_shipdate<DATE '1995-10-01';
create or replace view aggView6921976703646101871 as select v2, v6 * (1 - v7) as caseRes, SUM(v6 * (1 - v7)) as v29, COUNT(*) as annot from semiDown5385992646031380013 group by v2,caseRes;
create or replace view aggJoin4326354638106816171 as select v21, caseRes, v29, annot from semiUp1729250738167113874 join aggView6921976703646101871 using(v2);
select ((100.0 * SUM(CASE WHEN (v21 LIKE 'PROMO%') THEN caseRes*annot ELSE 0.0 END)) / SUM(v30)) from aggJoin4326354638106816171;
