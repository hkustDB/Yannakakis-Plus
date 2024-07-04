create or replace view aggView6199013276385630597 as select dst as v2, SUM(src) as v9, COUNT(*) as annot from Graph as g1 group by dst;
create or replace view aggJoin3537952455715309546 as select src as v2, dst as v4, v9, annot from Graph as g2, aggView6199013276385630597 where g2.src=aggView6199013276385630597.v2 and src<dst;
create or replace view semiJoinView1249148677264393410 as select src as v4, dst as v6 from Graph AS g3 where (src) in (select (v4) from aggJoin3537952455715309546);
create or replace view semiJoinView7510674712151086670 as select distinct src as v6, dst as v8 from Graph AS g4 where (src) in (select (v6) from semiJoinView1249148677264393410);
create or replace view semiEnum5152627456983167916 as select distinct v4, v8 from semiJoinView7510674712151086670 join semiJoinView1249148677264393410 using(v6);
create or replace view semiEnum646694482275976168 as select v8, v9, v2, annot from semiEnum5152627456983167916 join aggJoin3537952455715309546 using(v4);
select v2,v8,SUM(v9) as v9 from semiEnum646694482275976168 group by v2, v8;
