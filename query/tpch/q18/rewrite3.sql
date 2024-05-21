create or replace view aggView6739258701789052001 as select c_name as v2, c_custkey as v1 from customer as customer;
create or replace view aggView1471952055101280508 as select o_totalprice as v12, o_orderkey as v9, o_custkey as v1, o_orderdate as v13 from orders as orders;
create or replace view aggView3664420267127271651 as select v1_orderkey as v9 from q18_inner as q18_inner;
create or replace view aggJoin7778781481622489446 as select v12, v9, v1, v13 from aggView1471952055101280508 join aggView3664420267127271651 using(v9);
create or replace view aggView5521260041768851821 as select l_orderkey as v9, SUM(l_quantity) as v35, COUNT(*) as annot from lineitem as lineitem group by l_orderkey,v9;
create or replace view aggJoin5398555787813874058 as select v12, v9, v1, v13, v35, annot from aggJoin7778781481622489446 join aggView5521260041768851821 using(v9);
create or replace view aggView5005192139272233718 as select v1, v2 from aggView6739258701789052001;
create or replace view aggJoin4574344692891056136 as select v12, v9, v1, v13, v35, v2 from aggJoin5398555787813874058 join aggView5005192139272233718 using(v1);
select v2,v1,v9,v13,v12,SUM(v35) as v35 from aggJoin4574344692891056136 group by v1, v2, v9, v12, v13;
