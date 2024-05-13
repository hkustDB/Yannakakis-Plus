create or replace view aggView6230164574405294752 as select c_name as v2, c_custkey as v1 from customer as customer;
create or replace view aggView3213108870177568704 as select o_orderdate as v13, o_custkey as v1, o_totalprice as v12, o_orderkey as v9 from orders as orders;
create or replace view aggView2883266407412384581 as select l_orderkey as v9, SUM(l_quantity) as v35, COUNT(*) as annot from lineitem as lineitem group by l_orderkey;
create or replace view aggJoin6182957772990754643 as select v1_orderkey as v9, v35, annot from q18_inner as q18_inner, aggView2883266407412384581 where q18_inner.v1_orderkey=aggView2883266407412384581.v9;
create or replace view semiJoinView3667829093644413739 as select v13, v1, v12, v9 from aggView3213108870177568704 where (v9) in (select (v9) from aggJoin6182957772990754643);
create or replace view semiJoinView8832280164337253405 as select distinct v2, v1 from aggView6230164574405294752 where (v1) in (select (v1) from semiJoinView3667829093644413739);
create or replace view semiEnum3348454401559063817 as select distinct v13, v2, v9, v1, v12 from semiJoinView8832280164337253405 join semiJoinView3667829093644413739 using(v1);
create or replace view semiEnum672524433038527621 as select v2, v9, annot, v13, v35, v1, v12 from semiEnum3348454401559063817 join aggJoin6182957772990754643 using(v9);
select v2,v1,v9,v13,v12,v35 from semiEnum672524433038527621;
