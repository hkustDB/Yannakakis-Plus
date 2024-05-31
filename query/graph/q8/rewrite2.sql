create or replace view semiJoinView7586401605753504591 as select src as v4, dst as v6 from Graph AS g3 where (dst) in (select src from Graph AS g4) and src<dst;
create or replace view semiJoinView5188756676643215086 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select dst from Graph AS g1) and src<dst;
create or replace view semiJoinView1683380066750366396 as select v4, v6 from semiJoinView7586401605753504591 where (v4) in (select v4 from semiJoinView5188756676643215086);
create or replace view semiEnum7088170181404430878 as select v6, v2, v4 from semiJoinView1683380066750366396 join semiJoinView5188756676643215086 using(v4);
create or replace view semiEnum7544831077436790617 as select v2, src as v1, v6, v4 from semiEnum7088170181404430878, Graph as g1 where g1.dst=semiEnum7088170181404430878.v2;
create or replace view semiEnum161463524936732687 as select v2, v1, dst as v8, v4, v6 from semiEnum7544831077436790617, Graph as g4 where g4.src=semiEnum7544831077436790617.v6;
select sum(v1+v2+v4+v6+v8) from semiEnum161463524936732687;
