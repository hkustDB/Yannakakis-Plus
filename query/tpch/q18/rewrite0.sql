create or replace view aggView8954701911462828878 as select o_orderkey as v9, o_totalprice as v12, o_custkey as v1, o_orderdate as v13 from orders as orders;
create or replace view aggView433952195415843449 as select c_name as v2, c_custkey as v1 from customer as customer;
create or replace view aggView7844005101442789301 as select l_orderkey as v9, SUM(l_quantity) as v35, COUNT(*) as annot from lineitem as lineitem group by l_orderkey,v9;
create or replace view aggJoin4693427054115621101 as select v1_orderkey as v9, v35, annot from q18_inner as q18_inner, aggView7844005101442789301 where q18_inner.v1_orderkey=aggView7844005101442789301.v9;
create or replace view aggView1272228730279501558 as select v9, SUM(v35) as v35, SUM(annot) as annot from aggJoin4693427054115621101 group by v9,v35;
create or replace view aggJoin6271392970387075405 as select v9, v12, v1, v13, v35, annot from aggView8954701911462828878 join aggView1272228730279501558 using(v9);
create or replace view aggView8381059485064036576 as select v1, SUM(v35) as v35, v9, v12, v13 from aggJoin6271392970387075405 group by v1,v9,v12,v13,v35;
create or replace view aggJoin6605049448082412820 as select v2, v1, v35, v9, v12, v13 from aggView433952195415843449 join aggView8381059485064036576 using(v1);
select v2,v1,v9,v13,v12,SUM(v35) as v35 from aggJoin6605049448082412820 group by v1, v2, v9, v12, v13;
