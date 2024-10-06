create or replace view aggView810620861276263361 as select o_custkey as v1, o_orderdate as v13, o_totalprice as v12, o_orderkey as v9 from orders as orders;
create or replace view aggView6314012356010745823 as select c_custkey as v1, c_name as v2 from customer as customer;
create or replace view aggView3007656820301418797 as select l_orderkey as v9, SUM(l_quantity) as v35, COUNT(*) as annot from lineitem as lineitem group by l_orderkey;
create or replace view aggJoin7165228096163872251 as select v1, v13, v12, v9, v35, annot from aggView810620861276263361 join aggView3007656820301418797 using(v9);
create or replace view semiJoinView532402596373068311 as select v1, v13, v12, v9, v35, annot from aggJoin7165228096163872251 where (v9) in (select v1_orderkey from q18_inner AS q18_inner);
create or replace view semiJoinView3320352535538900815 as select distinct v1, v2 from aggView6314012356010745823 where (v1) in (select v1 from semiJoinView532402596373068311);
create or replace view semiEnum1188894684123477190 as select distinct v1, v13, v12, v35, annot, v2, v9 from semiJoinView3320352535538900815 join semiJoinView532402596373068311 using(v1);
create or replace view semiEnum1226637339610155500 as select v35, v2, v1, v13, v12, v9 from semiEnum1188894684123477190, q18_inner as q18_inner where q18_inner.v1_orderkey=semiEnum1188894684123477190.v9;
select v2, v1, v9, v13, v12, v35 from semiEnum1226637339610155500;

