create or replace view aggJoin8569159789853423199 as select c_name as v2, c_custkey as v1 from customer as customer;
create or replace view aggJoin5679917854684106270 as select o_totalprice as v12, o_custkey as v1, o_orderkey as v9, o_orderdate as v13 from orders as orders;
create or replace view aggView1339431430406839815 as select l_orderkey as v9, SUM(l_quantity) as v35 from lineitem as lineitem group by l_orderkey;
create or replace view aggJoin4646737290775351442 as select v9, v1, v12, v13, v35 from aggJoin5679917854684106270 join aggView1339431430406839815 using(v9);
create or replace view semiJoinView47543529886992813 as select v9, v1, v12, v13, v35 from aggJoin4646737290775351442 where (v9) in (select v1_orderkey from q18_inner AS q18_inner);
create or replace view semiJoinView1776079612453880126 as select v9, v1, v12, v13, v35 from semiJoinView47543529886992813 where (v1) in (select v1 from aggJoin8569159789853423199);
create or replace view semiEnum363953621941025309 as select v2, v1, v12, v35, v9, v13 from semiJoinView1776079612453880126 join aggJoin8569159789853423199 using(v1);
create or replace view semiEnum1841738655352368582 as select v2, v1, v12, sum(v35) as v35, v9, v13 from semiEnum363953621941025309, q18_inner as q18_inner where q18_inner.v1_orderkey=semiEnum363953621941025309.v9 group by v2, v1, v12, v9, v13;
select sum(v1),sum(v2),sum(v9),sum(v12),sum(v13),sum(v35) from semiEnum1841738655352368582;
