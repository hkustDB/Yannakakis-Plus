create or replace view semiUp6202188780695040087 as select p_partkey as v6, p_brand as v9, p_type as v10, p_size as v11 from part AS part where (p_partkey) in (select ps_partkey from partsupp AS partsupp) and p_brand<> 'Brand#45' and p_type NOT LIKE 'MEDIUM POLISHED%' and p_size IN (49,14,23,45,19,3,36,9);
create or replace view partAux63 as select v9, v10, v11 from semiUp6202188780695040087;
create or replace view semiDown3357453452641617529 as select v6, v9, v10, v11 from semiUp6202188780695040087 where (v9, v10, v11) in (select v9, v10, v11 from partAux63);
create or replace view semiDown7916621178234031947 as select ps_partkey as v6 from partsupp AS partsupp where (ps_partkey) in (select v6 from semiDown3357453452641617529);
create or replace view aggView7473594579668316492 as select v6, COUNT(*) as annot from semiDown7916621178234031947 group by v6;
create or replace view aggJoin3986742506268607899 as select v9, v10, v11, annot from semiDown3357453452641617529 join aggView7473594579668316492 using(v6);
create or replace view aggView7794489038438901440 as select v9, v10, v11, SUM(annot) as annot from aggJoin3986742506268607899 group by v9,v10,v11;
create or replace view res as select v9, v10, v11, annot as v15 from aggView7794489038438901440;
select sum(v9), sum(v10), sum(v11), sum(v15) from res;
