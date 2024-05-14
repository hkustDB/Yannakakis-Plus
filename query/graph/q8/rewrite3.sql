create or replace view semiJoinView7960500862767761549 as select src as v4, dst as v6 from Graph AS g3 where (dst) in (select (src) from Graph AS g4) and src<dst;
create or replace view semiJoinView8679364000513251910 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select (v4) from semiJoinView7960500862767761549) and src<dst;
create or replace view semiJoinView8282508662277583608 as select v2, v4 from semiJoinView8679364000513251910 where (v2) in (select (dst) from Graph AS g1);
create or replace view semiEnum511113344693500659 as select v4, src as v1, v2 from semiJoinView8282508662277583608, Graph as g1 where g1.dst=semiJoinView8282508662277583608.v2;
create or replace view semiEnum7878182272659387624 as select v4, v6, v1, v2 from semiEnum511113344693500659 join semiJoinView7960500862767761549 using(v4);
create or replace view semiEnum3116866089454449778 as select v4, v6, v1, v2, dst as v8 from semiEnum7878182272659387624, Graph as g4 where g4.src=semiEnum7878182272659387624.v6;
select v1, v2, v4, v6, v8 from semiEnum3116866089454449778;
