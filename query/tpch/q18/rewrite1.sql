create or replace view aggView8332612307866309136 as select c_name as v2, c_custkey as v1 from customer as customer;
create or replace view aggView3925985072024311107 as select o_totalprice as v12, o_orderkey as v9, o_custkey as v1, o_orderdate as v13 from orders as orders;
create or replace view aggView2753596546360130738 as select l_orderkey as v9, SUM(l_quantity) as v35, COUNT(*) as annot from lineitem as lineitem group by l_orderkey,v9;
create or replace view aggJoin2701003659168497691 as select v1_orderkey as v9, v35, annot from q18_inner as q18_inner, aggView2753596546360130738 where q18_inner.v1_orderkey=aggView2753596546360130738.v9;
create or replace view aggView6658095675650738743 as select v9, SUM(v35) as v35, SUM(annot) as annot from aggJoin2701003659168497691 group by v9,v35;
create or replace view aggJoin6206033633546833496 as select v12, v9, v1, v13, v35, annot from aggView3925985072024311107 join aggView6658095675650738743 using(v9);
create or replace view aggView3903425438391363801 as select v1, v2 from aggView8332612307866309136 group by v1,v2;
create or replace view aggJoin140228834879142929 as select v12, v9, v1, v13, v35*aggView3903425438391363801.annot as v35, v2 from aggJoin6206033633546833496 join aggView3903425438391363801 using(v1);
select v2,v1,v9,v13,v12,SUM(v35) as v35 from aggJoin140228834879142929 group by v1, v2, v9, v12, v13;
