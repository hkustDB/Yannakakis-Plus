create or replace view semiUp7098945134377262248 as select ps_partkey as v6 from partsupp AS partsupp where (ps_partkey) in (select p_partkey from part AS part where p_brand<> 'Brand#45' and p_type NOT LIKE 'MEDIUM POLISHED%' and p_size IN (49,14,23,45,19,3,36,9));
create or replace view semiDown5406622728731679667 as select p_partkey as v6, p_brand as v9, p_type as v10, p_size as v11 from part AS part where (p_partkey) in (select v6 from semiUp7098945134377262248) and p_brand<> 'Brand#45' and p_type NOT LIKE 'MEDIUM POLISHED%' and p_size IN (49,14,23,45,19,3,36,9);
create or replace view aggView7110155246408571591 as select v6, v10, v9, v11 from semiDown5406622728731679667;
create or replace view aggJoin307789876971765317 as select v10, v9, v11 from semiUp7098945134377262248 join aggView7110155246408571591 using(v6);
select v9,v10,v11,COUNT(*) as v15 from aggJoin307789876971765317 group by v9, v10, v11;
