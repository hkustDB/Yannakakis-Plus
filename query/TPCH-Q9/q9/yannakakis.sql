create or replace view l_0 as select l_returnflag as x1, l_orderkey as x2, l_partkey as x3, l_suppkey as x4, l_quantity from lineitem_5 where exists (select 1 from orders_5 where l_orderkey = o_orderkey and o_orderdate < DATE '1996-12-31' and o_orderdate > DATE '1996-01-01');
create or replace view ps_0 as select ps_partkey as x3, ps_suppkey as x4, ps_supplycost from partsupp_5 where exists (select 1 from part_5 where ps_partkey = p_partkey and p_name LIKE '%blue%');
create or replace view l_1 as select x1, x2, x3, x4, l_quantity from l_0 where exists (select 1 from ps_0 where ps_0.x3 = l_0.x3 and l_0.x4 = x4);
create or replace view s_0 as select s_suppkey as x4, s_nationkey as x7 from supplier_5 where exists (select 1 from l_1 where s_suppkey = l_1.x4);
create or replace view s_1 as select x4, x7 from s_0 where exists (select 1 from nation_5 where x7 = n_nationkey);

create or replace view n_0 as select n_nationkey as x7, n_name as x8 from nation_5 where exists (select 1 from s_1 where n_nationkey = s_1.x7);
create or replace view l_2 as select x1, x2, x3, x4, l_quantity from l_1 where exists (select 1 from s_1 where s_1.x4 = l_1.x4);
create or replace view ps_1 as select x3, x4, ps_supplycost from ps_0 where exists (select 1 from l_2 where ps_0.x3 = x3 and ps_0.x4 = x4);
create or replace view p_0 as select p_partkey as x3 from part_5 where p_name LIKE '%blue%' and exists (select 1 from ps_1 where ps_1.x3 = p_partkey);
create or replace view o_0 as select o_orderkey as x2 from orders_5 where o_orderdate < DATE '1996-12-31' and o_orderdate > DATE '1996-01-01' and exists (select 1 from l_2 where l_2.x2 = o_orderkey);

create or replace view l_3 as select x1, x2, x3, x4, l_quantity from l_2 join o_0 using (x2);
create or replace view ps_2 as select x3, x4, SUM(ps_supplycost) as ps_supplycost from ps_1 join p_0 using (x3) group by x3, x4;
create or replace view l_4 as select x1, x2, x4, SUM(l_quantity * ps_supplycost) as part_cost from l_3 join ps_2 using (x3, x4) group by x1, x2, x4;
create or replace view s_2 as select x1, x2, x7, part_cost from l_4 join s_1 using (x4);
create or replace view n_1 as select x7, x8, COUNT(*) as annot from n_0 group by x7, x8;
select x1, x2, x8, SUM(part_cost * annot) as part_cost from s_2 join n_1 using (x7) group by x1, x2, x8;