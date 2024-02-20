## AggReduce Phase: 

# AggReduce0
# 1. aggView
create or replace view aggView5747456870505220386 as select ps_partkey as v6, COUNT(*) as annot from partsupp as partsupp group by ps_partkey;
# 2. aggJoin
create or replace view aggJoin3502476827225720184 as select p_brand as v9, p_type as v10, p_size as v11, annot from part as part, aggView5747456870505220386 where part.p_partkey=aggView5747456870505220386.v6 and p_brand<> 'Brand#45' and p_type NOT LIKE 'MEDIUM POLISHED%' and p_size IN (49,14,23,45,19,3,36,9);

# AggReduce1
# 1. aggView
create or replace view aggView8403583978697177144 as select v10, v11, v9, SUM(annot) as annot from aggJoin3502476827225720184 group by v10,v11,v9;
# 2. aggJoin
create or replace view aggJoin2014643660303069644 as select v9, v10, v11, annot from aggView8403583978697177144;
# Final result: 
select v9,v10,v11,annot as v15 from aggJoin2014643660303069644;

# drop view aggView5747456870505220386, aggJoin3502476827225720184, aggView8403583978697177144, aggJoin2014643660303069644;
