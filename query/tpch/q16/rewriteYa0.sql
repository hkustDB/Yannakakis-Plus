create or replace view semiUp2799169592335795259 as select p_partkey as v6, p_brand as v9, p_type as v10, p_size as v11 from part AS part where (p_partkey) in (select (ps_partkey) from partsupp AS partsupp) and p_brand<> 'Brand#45' and p_type NOT LIKE 'MEDIUM POLISHED%' and p_size IN (49,14,23,45,19,3,36,9);
create or replace view partAux74 as select v9, v10, v11 from semiUp2799169592335795259;
create or replace view semiDown2151241303616437494 as select v6, v9, v10, v11 from semiUp2799169592335795259 where (v11, v9, v10) in (select (v11, v9, v10) from partAux74);
create or replace view semiDown6746765796225974510 as select ps_partkey as v6 from partsupp AS partsupp where (ps_partkey) in (select (v6) from semiDown2151241303616437494);
create or replace view aggView1997142418657858749 as select v6, COUNT(*) as annot from semiDown6746765796225974510 group by v6;
create or replace view aggJoin459673923516142036 as select v9, v10, v11, annot from semiDown2151241303616437494 join aggView1997142418657858749 using(v6);
create or replace view aggView8324871082494793507 as select v11, v9, v10, SUM(annot) as annot from aggJoin459673923516142036 group by v11,v9,v10;
select v9,v10,v11,annot as v15 from aggView8324871082494793507;
