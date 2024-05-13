create or replace view aggView2157404493496220770 as select c_name as v2, c_custkey as v1 from customer as customer;
create or replace view aggView7364045347234840150 as select o_orderdate as v13, o_custkey as v1, o_totalprice as v12, o_orderkey as v9 from orders as orders;
create or replace view aggView2616484137401611792 as select l_orderkey as v9, SUM(l_quantity) as v35, COUNT(*) as annot from lineitem as lineitem group by l_orderkey;
create or replace view aggJoin5217020973293201480 as select v13, v1, v12, v9, v35, annot from aggView7364045347234840150 join aggView2616484137401611792 using(v9);
create or replace view semiJoinView2071409920542951683 as select v13, v1, v12, v9, v35, annot from aggJoin5217020973293201480 where (v9) in (select (v1_orderkey) from q18_inner AS q18_inner);
create or replace view semiJoinView5003893357902529858 as select distinct v2, v1 from aggView2157404493496220770 where (v1) in (select (v1) from semiJoinView2071409920542951683);
create or replace view semiEnum6547724757861551212 as select distinct v13, v2, v35, v1, v9, annot, v12 from semiJoinView5003893357902529858 join semiJoinView2071409920542951683 using(v1);
create or replace view semiEnum5476711797684810449 as select v2, v9, annot, v13, v35, v1, v12 from semiEnum6547724757861551212, q18_inner as q18_inner where q18_inner.v1_orderkey=semiEnum6547724757861551212.v9;
select v2,v1,v9,v13,v12,v35 from semiEnum5476711797684810449;
