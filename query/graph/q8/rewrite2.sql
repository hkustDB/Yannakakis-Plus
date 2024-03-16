create or replace view semiJoinView7676284182163486166 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select dst from Graph AS g1) and src<dst;
create or replace view semiJoinView4385028703003847997 as select src as v4, dst as v6 from Graph AS g3 where (src) in (select v4 from semiJoinView7676284182163486166) and src<dst;
create or replace view semiJoinView117083202031491843 as select v4, v6 from semiJoinView4385028703003847997 where (v6) in (select src from Graph AS g4);
create or replace view semiEnum623831972497683823 as select dst as v8, v6, v4 from semiJoinView117083202031491843, Graph as g4 where g4.src=semiJoinView117083202031491843.v6;
create or replace view semiEnum4560295915362080364 as select v8, v2, v4, v6 from semiEnum623831972497683823 join semiJoinView7676284182163486166 using(v4);
create or replace view semiEnum1051243208748421113 as select v8, v2, v4, src as v1, v6 from semiEnum4560295915362080364, Graph as g1 where g1.dst=semiEnum4560295915362080364.v2;
select sum(v1+v2+v4+v6+v8) from semiEnum1051243208748421113;
