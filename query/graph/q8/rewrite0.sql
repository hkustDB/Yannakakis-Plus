create or replace view semiJoinView8643758646611640140 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select (dst) from Graph AS g1) and src<dst;
create or replace view semiJoinView4163727295118820546 as select src as v4, dst as v6 from Graph AS g3 where (src) in (select (v4) from semiJoinView8643758646611640140) and src<dst;
create or replace view semiJoinView7998432924601132436 as select src as v6, dst as v8 from Graph AS g4 where (src) in (select (v6) from semiJoinView4163727295118820546);
create or replace view semiEnum2683287425303517034 as select v4, v6, v8 from semiJoinView7998432924601132436 join semiJoinView4163727295118820546 using(v6);
create or replace view semiEnum478299812717723096 as select v4, v6, v2, v8 from semiEnum2683287425303517034 join semiJoinView8643758646611640140 using(v4);
create or replace view semiEnum3694469834356361260 as select v4, src as v1, v2, v6, v8 from semiEnum478299812717723096, Graph as g1 where g1.dst=semiEnum478299812717723096.v2;
select v1, v2, v4, v6, v8 from semiEnum3694469834356361260;
