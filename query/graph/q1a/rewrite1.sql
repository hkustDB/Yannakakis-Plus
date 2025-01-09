create or replace view semiJoinView6396603228425918825 as select src as v4, dst as v6 from Graph AS g3 where (dst) in (select (src) from Graph AS g4) and src<dst;
create or replace view semiJoinView7793714103318843618 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select (v4) from semiJoinView6396603228425918825) and src<dst;
create or replace view semiJoinView7939754139722786602 as select src as v1, dst as v2 from Graph AS g1 where (dst) in (select (v2) from semiJoinView7793714103318843618);
create or replace view semiEnum4813194778132182632 as select v2, v1, v4 from semiJoinView7939754139722786602 join semiJoinView7793714103318843618 using(v2);
create or replace view semiEnum2273099266798329331 as select v2, v4, v1, v6 from semiEnum4813194778132182632 join semiJoinView6396603228425918825 using(v4);
create or replace view semiEnum8055061395645332304 as select v4, dst as v8, v2, v1, v6 from semiEnum2273099266798329331, Graph as g4 where g4.src=semiEnum2273099266798329331.v6;
select v1, v2, v4, v6, v8 from semiEnum8055061395645332304;
