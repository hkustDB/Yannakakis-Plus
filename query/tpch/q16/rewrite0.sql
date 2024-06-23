create or replace view aggView6538563832990326354 as select ps_partkey as v6, COUNT(*) as annot from partsupp as partsupp group by ps_partkey;
create or replace view aggJoin5405656525080441978 as select p_brand as v9, p_type as v10, p_size as v11, annot from part as part, aggView6538563832990326354 where part.p_partkey=aggView6538563832990326354.v6 and p_brand<> 'Brand#45' and p_type NOT LIKE 'MEDIUM POLISHED%' and p_size IN (49,14,23,45,19,3,36,9);
create or replace view aggView6345340139947675188 as select v11, v9, v10, SUM(annot) as annot from aggJoin5405656525080441978 group by v11,v9,v10;
create or replace view res as select v9, v10, v11, annot as v15 from aggView6345340139947675188;
select sum(v9), sum(v10), sum(v11), sum(v15) from res;