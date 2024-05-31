create or replace view aggView4693375675154081903 as select c_name as v2, c_custkey as v1 from customer as customer;
create or replace view aggView792166705002098357 as select o_orderkey as v9, o_totalprice as v12, o_custkey as v1, o_orderdate as v13 from orders as orders;
create or replace view aggView7079201872044084586 as select v1_orderkey as v9 from q18_inner as q18_inner;
create or replace view aggJoin3136623008274062297 as select v9, v12, v1, v13 from aggView792166705002098357 join aggView7079201872044084586 using(v9);
create or replace view aggView9162133196332433852 as select v1, v2, COUNT(*) as annot from aggView4693375675154081903 group by v1,v2;
create or replace view aggJoin1902298781990882624 as select v9, v12, v1, v13, v2, annot from aggJoin3136623008274062297 join aggView9162133196332433852 using(v1);
create or replace view aggView3235459124632175424 as select l_orderkey as v9, SUM(l_quantity) as v35 from lineitem as lineitem group by l_orderkey,v9;
create or replace view aggJoin1145322285844224090 as select v9, v12, v1, v13, v2, v35 * aggJoin1902298781990882624.annot as v35 from aggJoin1902298781990882624 join aggView3235459124632175424 using(v9);
select v2,v1,v9,v13,v12,SUM(v35) as v35 from aggJoin1145322285844224090 group by v1, v2, v9, v12, v13;
