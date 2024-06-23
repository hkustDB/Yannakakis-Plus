create or replace view semiUp5778235322646759694 as select l_partkey as v17, l_extendedprice as v6, l_discount as v7 from lineitem AS lineitem where (l_partkey) in (select p_partkey from part AS part where p_brand= 'Brand#34' and p_size>=1 and p_container IN ('LG CASE','LG BOX','LG PACK','LG PKG') and p_size<=15) and l_quantity>=21 and l_shipinstruct= 'DELIVER IN PERSON' and l_quantity<=21 + 10 and l_shipmode IN ('AIR','AIR REG');
create or replace view lineitemAux62 as select v6, v7 from semiUp5778235322646759694;
create or replace view semiDown252849759157820604 as select v17, v6, v7 from semiUp5778235322646759694 where (v7, v6) in (select v7, v6 from lineitemAux62);
create or replace view semiDown2339713942960296628 as select p_partkey as v17 from part AS part where (p_partkey) in (select v17 from semiDown252849759157820604) and p_brand= 'Brand#34' and p_size>=1 and p_container IN ('LG CASE','LG BOX','LG PACK','LG PKG') and p_size<=15;
create or replace view aggView8277960373235044004 as select v17 from semiDown2339713942960296628;
create or replace view aggJoin4345679226895503561 as select v6, v7 from semiDown252849759157820604 join aggView8277960373235044004 using(v17);
create or replace view aggView94241150717813618 as select v7, v6, SUM(v6 * (1 - v7)) as v27, COUNT(*) as annot from aggJoin4345679226895503561 group by v7,v6;
select SUM(v27) from aggView94241150717813618;
