create or replace view semiUp171388673558521313 as select l_partkey as v17, l_extendedprice as v6, l_discount as v7 from lineitem AS lineitem where (l_partkey) in (select p_partkey from part AS part where p_brand= 'Brand#34' and p_size>=1 and p_container IN ('LG CASE','LG BOX','LG PACK','LG PKG') and p_size<=15) and l_quantity>=21 and l_shipinstruct= 'DELIVER IN PERSON' and l_quantity<=21 + 10 and l_shipmode IN ('AIR','AIR REG');
create or replace view semiDown471191034622720660 as select p_partkey as v17 from part AS part where (p_partkey) in (select v17 from semiUp171388673558521313) and p_brand= 'Brand#34' and p_size>=1 and p_container IN ('LG CASE','LG BOX','LG PACK','LG PKG') and p_size<=15;
create or replace view aggView937446625105840731 as select v17 from semiDown471191034622720660;
create or replace view aggJoin6064087226286578676 as select v6, v7 from semiUp171388673558521313 join aggView937446625105840731 using(v17);
create or replace view res as select SUM((v6 * (1 - v7))) as v27 from aggJoin6064087226286578676;
select sum(v27) from res;
