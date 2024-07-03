create or replace view semiUp5306088963453773150 as select p_partkey as v6, p_brand as v9, p_type as v10, p_size as v11 from part AS part where (p_partkey) in (select ps_partkey from partsupp AS partsupp) and p_brand<> 'Brand#45' and p_type NOT LIKE 'MEDIUM POLISHED%' and p_size IN (49,14,23,45,19,3,36,9);
create or replace view partAux39 as select v9, v10, v11 from semiUp5306088963453773150;
create or replace view semiDown281174945834874580 as select v6, v9, v10, v11 from semiUp5306088963453773150 where (v10, v9, v11) in (select v10, v9, v11 from partAux39);
create or replace view semiDown7824054435586954385 as select ps_partkey as v6 from partsupp AS partsupp where (ps_partkey) in (select v6 from semiDown281174945834874580);
create or replace view aggView1407100836451050913 as select v6, COUNT(*) as annot from semiDown7824054435586954385 group by v6;
create or replace view aggJoin3940774037287334594 as select v9, v10, v11, annot from semiDown281174945834874580 join aggView1407100836451050913 using(v6);
create or replace view aggView6743370589466392280 as select v10, v9, v11, SUM(annot) as annot from aggJoin3940774037287334594 group by v10,v9,v11;
select v9,v10,v11,annot as v15 from aggView6743370589466392280;
