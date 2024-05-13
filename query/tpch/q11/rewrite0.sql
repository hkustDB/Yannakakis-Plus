create or replace view aggView8280616198715040823 as select n_nationkey as v9 from nation as nation where n_name= 'GERMANY';
create or replace view aggJoin7289845675253282918 as select s_suppkey as v2 from supplier as supplier, aggView8280616198715040823 where supplier.s_nationkey=aggView8280616198715040823.v9;
create or replace view aggView5150453721424200765 as select v2, COUNT(*) as annot from aggJoin7289845675253282918 group by v2;
create or replace view aggJoin5051148823521202205 as select ps_partkey as v1, ps_availqty as v3, ps_supplycost as v4, annot from partsupp as partsupp, aggView5150453721424200765 where partsupp.ps_suppkey=aggView5150453721424200765.v2;
create or replace view aggView5739400921579220280 as select v1, SUM(annot) as annot from aggJoin5051148823521202205;
select v1,((v4 * v3))* annot as v18 from aggView5739400921579220280;
