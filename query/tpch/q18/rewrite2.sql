create or replace view aggView6723948901473707578 as select o_totalprice as v12, o_orderkey as v9, o_custkey as v1, o_orderdate as v13 from orders as orders;
create or replace view aggView6143429459984958936 as select c_name as v2, c_custkey as v1 from customer as customer;
create or replace view aggView3821583283115863852 as select v1_orderkey as v9 from q18_inner as q18_inner;
create or replace view aggJoin7874907223904028357 as select v12, v9, v1, v13 from aggView6723948901473707578 join aggView3821583283115863852 using(v9);
create or replace view aggView418734586836044957 as select l_orderkey as v9, SUM(l_quantity) as v35, COUNT(*) as annot from lineitem as lineitem group by l_orderkey,v9;
create or replace view aggJoin2037632745669185196 as select v12, v1, v13, v9, v35, annot from aggJoin7874907223904028357 join aggView418734586836044957 using(v9);
create or replace view aggView8074838104121648080 as select v1, SUM(v35) as v35, v13, v12, v9 from aggJoin2037632745669185196 group by v1,v13,v12,v35,v9;
create or replace view aggJoin6543249771632093236 as select v2, v1, v35, v13, v12, v9 from aggView6143429459984958936 join aggView8074838104121648080 using(v1);
select v2,v1,v9,v13,v12,SUM(v35) as v35 from aggJoin6543249771632093236 group by v1, v2, v9, v12, v13;
