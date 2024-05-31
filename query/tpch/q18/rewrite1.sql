create or replace view aggView6499352702882695154 as select o_orderkey as v9, o_totalprice as v12, o_custkey as v1, o_orderdate as v13 from orders as orders;
create or replace view aggView3062556061805166977 as select c_name as v2, c_custkey as v1 from customer as customer;
create or replace view aggView704068957499967660 as select v1_orderkey as v9 from q18_inner as q18_inner;
create or replace view aggJoin7277996612550525942 as select v9, v12, v1, v13 from aggView6499352702882695154 join aggView704068957499967660 using(v9);
create or replace view aggView7999913148548808150 as select l_orderkey as v9, SUM(l_quantity) as v35, COUNT(*) as annot from lineitem as lineitem group by l_orderkey,v9;
create or replace view aggJoin6529741661313022236 as select v9, v12, v1, v13, v35, annot from aggJoin7277996612550525942 join aggView7999913148548808150 using(v9);
create or replace view aggView5724491314871269355 as select v1, SUM(v35) as v35, v9, v12, v13 from aggJoin6529741661313022236 group by v1,v9,v12,v13,v35;
create or replace view aggJoin8398602758228449833 as select v2, v1, v35, v9, v12, v13 from aggView3062556061805166977 join aggView5724491314871269355 using(v1);
select v2,v1,v9,v13,v12,SUM(v35) as v35 from aggJoin8398602758228449833 group by v1, v2, v9, v12, v13;
