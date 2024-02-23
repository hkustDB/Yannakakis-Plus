create or replace view semiJoinView2912078581772148908 as select g1.src as v1, g3.dst as v6 from Graph as g1, Graph as g2, Graph as g3 where g1.dst=g2.src and g2.dst=g3.src;
create or replace view orderView8535017722574441733 as select v1, v6, row_number() over (partition by v6 order by v1) as rn from semiJoinView2912078581772148908;
create or replace view minView3408161782199540763 as select v6, v1 as mfL597871403586332073 from orderView8535017722574441733 where rn = 1;
create or replace view joinView2142250798062278878 as select src as v6, dst as v8, mfL597871403586332073 from Graph AS g4, minView3408161782199540763 where g4.src=minView3408161782199540763.v6 and mfL597871403586332073<dst;
create or replace view sample7602363158929732948 as select * from orderView8535017722574441733 where rn % 5 = 1;
create or replace view maxRn6428839532098765200 as select v6, max(rn) as mrn from joinView2142250798062278878 join sample7602363158929732948 using(v6) where v1<v8 group by v6;
create or replace view target8285946170378036229 as select v1, v6 from orderView8535017722574441733 join maxRn6428839532098765200 using(v6) where rn < mrn + 5;
create or replace view end4968659657995716154 as select v1, v6, v8 from joinView2142250798062278878 join target8285946170378036229 using(v6) where v1<v8;
select distinct v1, v6, v8 from end4968659657995716154;
