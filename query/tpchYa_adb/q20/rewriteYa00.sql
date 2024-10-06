create or replace view q20_inner1_view as select v1_partkey from q20_inner1 where exists (select 1 from partsupp where q20_inner1.v1_partkey=ps_partkey);
create or replace view ps_view as select ps_suppkey, ps_availqty from partsupp where exists (select 1 from q20_inner1_view where ps_partkey=v1_partkey);
select SUM(ps_suppkey) from ps_view, q20_inner2 where ps_availqty > v2_quantity_sum;