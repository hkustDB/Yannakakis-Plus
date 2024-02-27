create or replace view aggView6263289613287087625 as select ps_partkey as v6, COUNT(*) as annot from partsupp as partsupp group by ps_partkey;
create or replace view aggJoin4843330126190130316 as select p_brand as v9, p_type as v10, p_size as v11, annot from part as part, aggView6263289613287087625 where part.p_partkey=aggView6263289613287087625.v6 and p_brand<> 'Brand#45' and p_type NOT LIKE 'MEDIUM POLISHED%' and p_size IN (49,14,23,45,19,3,36,9);
create or replace view aggView4888313628318258674 as select v9, v10, v11, SUM(annot) as annot from aggJoin4843330126190130316 group by v9,v10,v11;
select sum(v9), sum(v10), sum(v11), sum(annot) from aggView4888313628318258674;
