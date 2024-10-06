create or replace view bag127751 as select q20_inner1.v1_partkey as v1, partsupp.ps_suppkey as v2, partsupp.ps_availqty as v3, partsupp.ps_supplycost as v4, partsupp.ps_comment as v5 from q20_inner1 as q20_inner1, partsupp as partsupp where q20_inner1.v1_partkey=partsupp.ps_partkey;
create or replace view bag127751Aux17 as select v2, v3 from bag127751;
create or replace view minView7025549945809927372 as select v2_quantity_sum as mfR2252953938350494781 from q20_inner2;
create or replace view joinView1199117323366793525 as select distinct v2 from bag127751Aux17, minView7025549945809927372 where v3>mfR2252953938350494781;
select distinct v2 from joinView1199117323366793525;

