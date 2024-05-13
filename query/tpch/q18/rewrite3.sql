create or replace view aggView4046107101686568695 as select c_name as v2, c_custkey as v1 from customer as customer;
create or replace view aggView4401784617354897043 as select o_orderdate as v13, o_custkey as v1, o_totalprice as v12, o_orderkey as v9 from orders as orders;
create or replace view aggView3854742481428702795 as select l_orderkey as v9, SUM(l_quantity) as v35, COUNT(*) as annot from lineitem as lineitem group by l_orderkey;
create or replace view aggJoin2937730713494147008 as select v13, v1, v12, v9, v35, annot from aggView4401784617354897043 join aggView3854742481428702795 using(v9);
create or replace view semiJoinView2844872778864589580 as select v13, v1, v12, v9, v35, annot from aggJoin2937730713494147008 where (v1) in (select (v1) from aggView4046107101686568695);
create or replace view semiJoinView4820422771128807642 as select distinct v13, v1, v12, v9, v35, annot from semiJoinView2844872778864589580 where (v9) in (select (v1_orderkey) from q18_inner AS q18_inner);
create or replace view semiEnum8773018411232269976 as select distinct v13, v35, v1, v9, annot, v12 from semiJoinView4820422771128807642, q18_inner as q18_inner where q18_inner.v1_orderkey=semiJoinView4820422771128807642.v9;
create or replace view semiEnum8421251718745389798 as select v2, v9, annot, v13, v35, v1, v12 from semiEnum8773018411232269976 join aggView4046107101686568695 using(v1);
select v2,v1,v9,v13,v12,v35 from semiEnum8421251718745389798;
