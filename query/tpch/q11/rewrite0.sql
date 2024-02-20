## AggReduce Phase: 

# AggReduce0
# 1. aggView
create or replace view aggView6282196524303435407 as select n_nationkey as v9, COUNT(*) as annot from nation as nation where n_name= 'GERMANY' group by n_nationkey;
# 2. aggJoin
create or replace view aggJoin219816334614146994 as select s_suppkey as v2, annot from supplier as supplier, aggView6282196524303435407 where supplier.s_nationkey=aggView6282196524303435407.v9;

# AggReduce1
# 1. aggView
create or replace view aggView4692329405768838565 as select v2, SUM(annot) as annot from aggJoin219816334614146994 group by v2;
# 2. aggJoin
create or replace view aggJoin3021301161703810555 as select ps_partkey as v1, ps_availqty as v3, ps_supplycost as v4, annot from partsupp as partsupp, aggView4692329405768838565 where partsupp.ps_suppkey=aggView4692329405768838565.v2;

# AggReduce2
# 1. aggView
create or replace view aggView1487891883693797251 as select v1, SUM((v4 * v3) * annot) as v18 from aggJoin3021301161703810555 group by v1;
# 2. aggJoin
create or replace view aggJoin2867305239980593107 as select v1, v18 from aggView1487891883693797251;
# Final result: 
select v1,v18 from aggJoin2867305239980593107;

# drop view aggView6282196524303435407, aggJoin219816334614146994, aggView4692329405768838565, aggJoin3021301161703810555, aggView1487891883693797251, aggJoin2867305239980593107;
