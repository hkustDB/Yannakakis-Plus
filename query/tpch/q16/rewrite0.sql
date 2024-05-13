create or replace view aggView6518315072461732421 as select ps_partkey as v6, COUNT(*) as annot from partsupp as partsupp group by ps_partkey;
create or replace view aggJoin130836583297377720 as select p_brand as v9, p_type as v10, p_size as v11, annot from part as part, aggView6518315072461732421 where part.p_partkey=aggView6518315072461732421.v6 and p_brand<> 'Brand#45' and p_type NOT LIKE 'MEDIUM POLISHED%' and p_size IN (49,14,23,45,19,3,36,9);
create or replace view aggView317754430158970646 as select v9, v10, v11, SUM(annot) as annot from aggJoin130836583297377720;
select v9,v10,v11,annot as v15 from aggView317754430158970646;
