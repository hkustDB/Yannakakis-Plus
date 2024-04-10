create or replace view semiUp3157170863089269194 as select p_partkey as v6, p_brand as v9, p_type as v10, p_size as v11 from part AS part where (p_partkey) in (select ps_partkey from partsupp AS partsupp) and p_brand<> 'Brand#45' and p_type NOT LIKE 'MEDIUM POLISHED%' and p_size IN (49,14,23,45,19,3,36,9);
create or replace view partAux32 as select v9, v10, v11 from semiUp3157170863089269194;
create or replace view semiDown2342158292679387027 as select v6, v9, v10, v11 from semiUp3157170863089269194 where (v9, v11, v10) in (select v9, v11, v10 from partAux32);
create or replace view semiDown8613034947480181496 as select ps_partkey as v6 from partsupp AS partsupp where (ps_partkey) in (select v6 from semiDown2342158292679387027);
create or replace view aggView1526037778747196255 as select v6, COUNT(*) as annot from semiDown8613034947480181496 group by v6;
create or replace view aggJoin3967166744985999004 as select v9, v10, v11, annot from semiDown2342158292679387027 join aggView1526037778747196255 using(v6);
create or replace view aggView3641322160028801126 as select v9, v11, v10, SUM(annot) as annot from aggJoin3967166744985999004 group by v9,v11,v10;
create or replace view res as select v9, v10, v11, annot as v15 from aggView3641322160028801126;
select sum(v9), sum(v10), sum(v11), sum(v15) from res;
