create or replace view aggView7897165890907656643 as select n_nationkey as v9 from nation as nation where n_name= 'GERMANY';
create or replace view aggJoin5284472984840104863 as select s_suppkey as v2 from supplier as supplier, aggView7897165890907656643 where supplier.s_nationkey=aggView7897165890907656643.v9;
create or replace view aggView1850690107284058337 as select v2, COUNT(*) as annot from aggJoin5284472984840104863 group by v2;
create or replace view aggJoin6267125681837102074 as select ps_partkey as v1, ps_availqty as v3, ps_supplycost as v4, annot from partsupp as partsupp, aggView1850690107284058337 where partsupp.ps_suppkey=aggView1850690107284058337.v2;
create or replace view aggView2649330889413008046 as select v1, SUM((v4 * v3) * annot) as v18 from aggJoin6267125681837102074 group by v1;
create or replace view res as select v1, v18 from aggView2649330889413008046;
select sum(v1), sum(v18) from res;