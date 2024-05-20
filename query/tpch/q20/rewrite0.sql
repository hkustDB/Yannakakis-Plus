create or replace view bag757137 as select q20_inner1.v1_partkey as v1, partsupp.ps_suppkey as v2, partsupp.ps_availqty as v3, partsupp.ps_supplycost as v4, partsupp.ps_comment as v5 from q20_inner1 as q20_inner1, partsupp as partsupp where q20_inner1.v1_partkey=partsupp.ps_partkey;
create or replace view bag757137Aux54 as select v2, v3 from bag757137;
create or replace view minView7690588047090578398 as select v2_quantity_sum as mfR8885372654007618366 from q20_inner2;
create or replace view joinView8596146146756564698 as select distinct v2 from bag757137Aux54, minView7690588047090578398 where v3>mfR8885372654007618366;
select distinct v2 from joinView8596146146756564698;
