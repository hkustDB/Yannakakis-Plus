create or replace view aggView8462017849986585670 as select o_custkey as v1, o_orderdate as v13, o_totalprice as v12, o_orderkey as v9 from orders as orders;
create or replace view aggView54348403258017812 as select c_custkey as v1, c_name as v2 from customer as customer;
create or replace view aggView595283457152935806 as select l_orderkey as v9, SUM(l_quantity) as v35, COUNT(*) as annot from lineitem as lineitem group by l_orderkey;
create or replace view aggJoin5683738591821640939 as select v1_orderkey as v9, v35, annot from q18_inner as q18_inner, aggView595283457152935806 where q18_inner.v1_orderkey=aggView595283457152935806.v9;
create or replace view semiJoinView2893812994214089006 as select v1, v13, v12, v9 from aggView8462017849986585670 where (v9) in (select v9 from aggJoin5683738591821640939);
create or replace view semiJoinView2988807664531565622 as select distinct v1, v2 from aggView54348403258017812 where (v1) in (select v1 from semiJoinView2893812994214089006);
create or replace view semiEnum1859715929988935406 as select distinct v1, v13, v12, v2, v9 from semiJoinView2988807664531565622 join semiJoinView2893812994214089006 using(v1);
create or replace view semiEnum8359210921319267879 as select v35, v2, v1, v13, v12, v9 from semiEnum1859715929988935406 join aggJoin5683738591821640939 using(v9);
select v2, v1, v9, v13, v12, v35 from semiEnum8359210921319267879;

