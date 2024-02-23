create or replace view bag1393 as select partsupp.ps_partkey as v1, partsupp.ps_suppkey as v2, partsupp.ps_availqty as v3, partsupp.ps_supplycost as v4, partsupp.ps_comment as v5 from partsupp as partsupp, view1 as view1 where partsupp.ps_partkey=view1.v1_partkey;
create or replace view bag1393Aux1 as select v2, v3 from bag1393;
create or replace view minView6989409938490300182 as select min(v2_quantity_sum) as mfR8224532533723091733 from view2;
create or replace view joinView3115954322466803854 as select v2 from bag1393Aux1, minView6989409938490300182 where v3>mfR8224532533723091733;
select distinct v2 from joinView3115954322466803854;
