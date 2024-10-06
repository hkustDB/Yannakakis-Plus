create or replace view aggView6900309189787214932 as select c_custkey as v1, c_name as v2 from customer as customer;
create or replace view aggView1578208343888713613 as select o_custkey as v1, o_orderdate as v13, o_totalprice as v12, o_orderkey as v9 from orders as orders;
create or replace view aggView7746491589849825976 as select l_orderkey as v9, SUM(l_quantity) as v35, COUNT(*) as annot from lineitem as lineitem group by l_orderkey;
create or replace view aggJoin7514980261853230416 as select v1_orderkey as v9, v35, annot from q18_inner as q18_inner, aggView7746491589849825976 where q18_inner.v1_orderkey=aggView7746491589849825976.v9;
create or replace view semiJoinView4622592223514790080 as select v1, v13, v12, v9 from aggView1578208343888713613 where (v9) in (select v9 from aggJoin7514980261853230416);
create or replace view semiJoinView8325647945396323772 as select distinct v1, v13, v12, v9 from semiJoinView4622592223514790080 where (v1) in (select v1 from aggView6900309189787214932);
create or replace view semiEnum794366243290250911 as select distinct v1, v13, v12, v2, v9 from semiJoinView8325647945396323772 join aggView6900309189787214932 using(v1);
create or replace view semiEnum5436907407687430606 as select v35, v2, v1, v13, v12, v9 from semiEnum794366243290250911 join aggJoin7514980261853230416 using(v9);
select v2, v1, v9, v13, v12, v35 from semiEnum5436907407687430606;

