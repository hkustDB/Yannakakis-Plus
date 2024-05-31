create or replace view semiJoinView8344527257288041724 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select dst from Graph AS g1);
create or replace view semiJoinView6422043767746545432 as select src as v4, dst as v6 from Graph AS g3 where (src) in (select v4 from semiJoinView8344527257288041724);
create or replace view semiJoinView6331651326533379716 as select distinct src as v6, dst as v8 from Graph AS g4 where (src) in (select v6 from semiJoinView6422043767746545432);
create or replace view semiEnum2309185966879913646 as select distinct v4, v8 from semiJoinView6331651326533379716 join semiJoinView6422043767746545432 using(v6);
create or replace view semiEnum2253909944919447389 as select distinct v2, v8 from semiEnum2309185966879913646 join semiJoinView8344527257288041724 using(v4);
create or replace view semiEnum5439156280715300919 as select v8, src as v1 from semiEnum2253909944919447389, Graph as g1 where g1.dst=semiEnum2253909944919447389.v2;
create or replace view res as select distinct v1, v8 from semiEnum5439156280715300919;
select sum(v1+v8) from res;
