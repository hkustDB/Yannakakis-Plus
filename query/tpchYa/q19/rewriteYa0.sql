create or replace view semiUp834809477637264041 as select l_partkey as v17, l_extendedprice as v6, l_discount as v7 from lineitem AS lineitem where (l_partkey) in (select p_partkey from part AS part where p_brand= 'Brand#34' and p_size>=1 and p_container IN ('LG CASE','LG BOX','LG PACK','LG PKG') and p_size<=15) and l_quantity>=21 and l_shipinstruct= 'DELIVER IN PERSON' and l_quantity<=21 + 10 and l_shipmode IN ('AIR','AIR REG');
create or replace view lineitemAux86 as select v6, v7 from semiUp834809477637264041;
create or replace view semiDown3962119218146761701 as select v17, v6, v7 from semiUp834809477637264041 where (v6, v7) in (select v6, v7 from lineitemAux86);
create or replace view semiDown1144623602008290838 as select p_partkey as v17 from part AS part where (p_partkey) in (select v17 from semiDown3962119218146761701) and p_brand= 'Brand#34' and p_size>=1 and p_container IN ('LG CASE','LG BOX','LG PACK','LG PKG') and p_size<=15;
create or replace view aggView5140700904428029297 as select v17 from semiDown1144623602008290838;
create or replace view aggJoin2683303857744378603 as select v6, v7 from semiDown3962119218146761701 join aggView5140700904428029297 using(v17);
create or replace view aggView4583186047681515233 as select v7, v6, SUM(v6 * (1 - v7)) as v27, COUNT(*) as annot from aggJoin2683303857744378603 group by v7,v6;
select SUM(v27) as v27 from aggView4583186047681515233;
