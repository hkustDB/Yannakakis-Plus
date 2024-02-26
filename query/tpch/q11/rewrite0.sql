create or replace view aggView4897025607405372140 as select n_nationkey as v9 from nation as nation where n_name= 'GERMANY';
create or replace view aggJoin8720487430221601030 as select s_suppkey as v2 from supplier as supplier, aggView4897025607405372140 where supplier.s_nationkey=aggView4897025607405372140.v9;
create or replace view aggView7635170092994251304 as select v2, count(*) as annot from aggJoin8720487430221601030 group by v2;
create or replace view aggJoin3679728202720721536 as select ps_partkey as v1, ps_availqty as v3, ps_supplycost as v4, annot from partsupp as partsupp, aggView7635170092994251304 where partsupp.ps_suppkey=aggView7635170092994251304.v2;
create or replace view aggView9022859933721060517 as select v1, SUM((v4 * v3) * annot) as v18 from aggJoin3679728202720721536 group by v1;
select v1, v18 from aggView9022859933721060517;
