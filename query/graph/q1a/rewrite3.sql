create or replace view semiJoinView5603684658867126138 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select (dst) from Graph AS g1) and src<dst;
create or replace view semiJoinView7980160971171148399 as select src as v4, dst as v6 from Graph AS g3 where (dst) in (select (src) from Graph AS g4) and src<dst;
create or replace view semiJoinView4238828884571263277 as select v2, v4 from semiJoinView5603684658867126138 where (v4) in (select (v4) from semiJoinView7980160971171148399);
create or replace view semiEnum7766781246943568282 as select v4, v2, v6 from semiJoinView4238828884571263277 join semiJoinView7980160971171148399 using(v4);
create or replace view semiEnum8124829848517041685 as select v2, dst as v8, v4, v6 from semiEnum7766781246943568282, Graph as g4 where g4.src=semiEnum7766781246943568282.v6;
create or replace view semiEnum1241037109965867026 as select v4, v8, v2, src as v1, v6 from semiEnum8124829848517041685, Graph as g1 where g1.dst=semiEnum8124829848517041685.v2;
select v1, v2, v4, v6, v8 from semiEnum1241037109965867026;
