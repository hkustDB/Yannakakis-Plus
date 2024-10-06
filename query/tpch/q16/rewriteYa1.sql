create or replace view semiUp1874392045605284279 as select ps_partkey as v6 from partsupp AS partsupp where (ps_partkey) in (select p_partkey from part AS part where p_brand<> 'Brand#45' and p_type NOT LIKE 'MEDIUM POLISHED%' and p_size IN (49,14,23,45,19,3,36,9));
create or replace view semiDown394787428572662958 as select p_partkey as v6, p_brand as v9, p_type as v10, p_size as v11 from part AS part where (p_partkey) in (select v6 from semiUp1874392045605284279) and p_brand<> 'Brand#45' and p_type NOT LIKE 'MEDIUM POLISHED%' and p_size IN (49,14,23,45,19,3,36,9);
create or replace view aggView8500612796080110154 as select v6, v9, v10, v11 from semiDown394787428572662958;
create or replace view aggJoin3309522863330800630 as select v9, v10, v11 from semiUp1874392045605284279 join aggView8500612796080110154 using(v6);
select v9, v10, v11, COUNT(*) as v15 from aggJoin3309522863330800630 group by v9, v10, v11;

