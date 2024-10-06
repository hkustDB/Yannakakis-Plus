create or replace view semiUp4105299744126173646 as select l_partkey as v17, l_extendedprice as v6, l_discount as v7 from lineitem AS lineitem where (l_partkey) in (select p_partkey from part AS part where p_brand= 'Brand#34' and p_size>=1 and p_container IN ('LG CASE','LG BOX','LG PACK','LG PKG') and p_size<=15) and l_quantity>=21 and l_shipinstruct= 'DELIVER IN PERSON' and l_quantity<=21 + 10 and l_shipmode IN ('AIR','AIR REG');
create or replace view semiDown618199020102334943 as select p_partkey as v17 from part AS part where (p_partkey) in (select v17 from semiUp4105299744126173646) and p_brand= 'Brand#34' and p_size>=1 and p_container IN ('LG CASE','LG BOX','LG PACK','LG PKG') and p_size<=15;
create or replace view aggView2452171719248044025 as select v17 from semiDown618199020102334943;
create or replace view aggJoin4583483073194908979 as select v6, v7 from semiUp4105299744126173646 join aggView2452171719248044025 using(v17);
select SUM((v6 * (1 - v7))) as v27 from aggJoin4583483073194908979;

