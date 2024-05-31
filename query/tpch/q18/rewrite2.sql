create or replace view aggView4374263798129835227 as select c_name as v2, c_custkey as v1 from customer as customer;
create or replace view aggView716030176374869623 as select o_orderkey as v9, o_totalprice as v12, o_custkey as v1, o_orderdate as v13 from orders as orders;
create or replace view aggView4013688056924109566 as select l_orderkey as v9, SUM(l_quantity) as v35, COUNT(*) as annot from lineitem as lineitem group by l_orderkey,v9;
create or replace view aggJoin7339255376032566120 as select v1_orderkey as v9, v35, annot from q18_inner as q18_inner, aggView4013688056924109566 where q18_inner.v1_orderkey=aggView4013688056924109566.v9;
create or replace view aggView1036183125654784061 as select v9, SUM(v35) as v35, SUM(annot) as annot from aggJoin7339255376032566120 group by v9,v35;
create or replace view aggJoin8588193574411934621 as select v9, v12, v1, v13, v35, annot from aggView716030176374869623 join aggView1036183125654784061 using(v9);
create or replace view aggView795777608893202321 as select v1, v2 from aggView4374263798129835227 group by v1,v2;
create or replace view aggJoin5095706049789162030 as select v9, v12, v1, v13, v35*aggView795777608893202321.annot as v35, v2 from aggJoin8588193574411934621 join aggView795777608893202321 using(v1);
select v2,v1,v9,v13,v12,SUM(v35) as v35 from aggJoin5095706049789162030 group by v1, v2, v9, v12, v13;
