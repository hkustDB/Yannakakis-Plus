create or replace view semiJoinView7249647192116182907 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select (dst) from Graph AS g1) and src<dst;
create or replace view semiJoinView3938121679960944337 as select src as v4, dst as v6 from Graph AS g3 where (dst) in (select (src) from Graph AS g4) and src<dst;
create or replace view semiJoinView8360289422424771339 as select v4, v6 from semiJoinView3938121679960944337 where (v4) in (select (v4) from semiJoinView7249647192116182907);
create or replace view semiEnum3493159771646407011 as select v4, v6, v2 from semiJoinView8360289422424771339 join semiJoinView7249647192116182907 using(v4);
create or replace view semiEnum3165931922471636087 as select v4, v6, v2, dst as v8 from semiEnum3493159771646407011, Graph as g4 where g4.src=semiEnum3493159771646407011.v6;
create or replace view semiEnum309397592137099122 as select v4, src as v1, v2, v6, v8 from semiEnum3165931922471636087, Graph as g1 where g1.dst=semiEnum3165931922471636087.v2;
select v1, v2, v4, v6, v8 from semiEnum309397592137099122;
