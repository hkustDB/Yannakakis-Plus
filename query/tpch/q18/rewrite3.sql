create or replace view aggJoin584531617986791440 as select c_name as v2, c_custkey as v1 from customer as customer ;
create or replace view aggJoin2072205776685426707 as select o_totalprice as v12, o_custkey as v1, o_orderkey as v9, o_orderdate as v13 from orders as orders;
create or replace view aggView1122704344889272867 as select l_orderkey as v9, SUM(l_quantity) as v35 from lineitem as lineitem group by l_orderkey;
create or replace view aggJoin694542283710982141 as select v9, v1, v12, v13, v35 from aggJoin2072205776685426707 join aggView1122704344889272867 using(v9);
create or replace view semiJoinView1284451586579235867 as select v9, v1, v12, v13, v35 from aggJoin694542283710982141 where (v9) in (select v1_orderkey from q18_inner AS q18_inner);
create or replace view semiJoinView4410651310275771594 as select v1, v2 from aggJoin584531617986791440 where (v1) in (select v1 from semiJoinView1284451586579235867);
create or replace view semiEnum1007805453398766735 as select v2, v1, v12, v35, v9, v13 from semiJoinView4410651310275771594 join semiJoinView1284451586579235867 using(v1);
create or replace view semiEnum4205195623423029981 as select v2, v1, v12, sum(v35) as v35, v9, v13 from semiEnum1007805453398766735, q18_inner as q18_inner where q18_inner.v1_orderkey=semiEnum1007805453398766735.v9 group by v2, v1, v12, v9, v13;
select sum(v1),sum(v2),sum(v9),sum(v12),sum(v13),sum(v35) from semiEnum4205195623423029981;
