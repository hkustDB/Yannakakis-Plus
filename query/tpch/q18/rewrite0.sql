create or replace view aggView7674753511798101810 as select o_totalprice as v12, o_orderkey as v9, o_custkey as v1, o_orderdate as v13 from orders as orders;
create or replace view aggView7613049143187993519 as select c_name as v2, c_custkey as v1 from customer as customer;
create or replace view aggView1548054123360797179 as select l_orderkey as v9, SUM(l_quantity) as v35, COUNT(*) as annot from lineitem as lineitem group by l_orderkey,v9;
create or replace view aggJoin8705270400673103395 as select v1_orderkey as v9, v35, annot from q18_inner as q18_inner, aggView1548054123360797179 where q18_inner.v1_orderkey=aggView1548054123360797179.v9;
create or replace view aggView6626735661156766473 as select v9, SUM(v35) as v35, SUM(annot) as annot from aggJoin8705270400673103395 group by v9,v35;
create or replace view aggJoin4167898357342903552 as select v12, v9, v1, v13, v35, annot from aggView7674753511798101810 join aggView6626735661156766473 using(v9);
create or replace view aggView2894822588739049236 as select v1, SUM(v35) as v35, v13, v12, v9 from aggJoin4167898357342903552 group by v1,v13,v12,v35,v9;
create or replace view aggJoin7517060184035423435 as select v2, v1, v35, v13, v12, v9 from aggView7613049143187993519 join aggView2894822588739049236 using(v1);
select v2,v1,v9,v13,v12,SUM(v35) as v35 from aggJoin7517060184035423435 group by v1, v2, v9, v12, v13;
