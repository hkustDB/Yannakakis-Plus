create or replace view aggView3062456529069071226 as select n_nationkey as v9 from nation as nation where n_name= 'GERMANY';
create or replace view aggJoin4796377750650424153 as select s_suppkey as v2 from supplier as supplier, aggView3062456529069071226 where supplier.s_nationkey=aggView3062456529069071226.v9;
create or replace view aggView9010917403516705937 as select v2, COUNT(*) as annot from aggJoin4796377750650424153 group by v2;
create or replace view aggJoin3463406725403559724 as select ps_partkey as v1, ps_availqty as v3, ps_supplycost as v4, annot from partsupp as partsupp, aggView9010917403516705937 where partsupp.ps_suppkey=aggView9010917403516705937.v2;
create or replace view aggView8715990928620269890 as select v1, SUM((v4 * v3) * annot) as v18 from aggJoin3463406725403559724 group by v1;
select v1,v18 from aggView8715990928620269890;
