create or replace view aggView8202533300119788061 as select c_name as v2, c_custkey as v1 from customer as customer;
create or replace view aggView8126712762015044393 as select o_orderdate as v13, o_custkey as v1, o_totalprice as v12, o_orderkey as v9 from orders as orders;
create or replace view aggView8256604207099521817 as select l_orderkey as v9, SUM(l_quantity) as v35, COUNT(*) as annot from lineitem as lineitem group by l_orderkey;
create or replace view aggJoin5505261164349850284 as select v1_orderkey as v9, v35, annot from q18_inner as q18_inner, aggView8256604207099521817 where q18_inner.v1_orderkey=aggView8256604207099521817.v9;
create or replace view semiJoinView8339071883322703799 as select v13, v1, v12, v9 from aggView8126712762015044393 where (v1) in (select (v1) from aggView8202533300119788061);
create or replace view semiJoinView3618264451701822394 as select distinct v13, v1, v12, v9 from semiJoinView8339071883322703799 where (v9) in (select (v9) from aggJoin5505261164349850284);
create or replace view semiEnum8254379446855080364 as select distinct v13, v35, v1, v9, annot, v12 from semiJoinView3618264451701822394 join aggJoin5505261164349850284 using(v9);
create or replace view semiEnum414201041697237915 as select v2, v9, annot, v13, v35, v1, v12 from semiEnum8254379446855080364 join aggView8202533300119788061 using(v1);
select v2,v1,v9,v13,v12,v35 from semiEnum414201041697237915;
