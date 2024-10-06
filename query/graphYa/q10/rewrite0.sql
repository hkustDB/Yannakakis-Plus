create or replace view aggView6444798924157659706 as select dst as v4, src as v2 from Graph as g2;
create or replace view aggJoin3203165394358097526 as select dst as v2 from Graph as g3, aggView6444798924157659706 where g3.src=aggView6444798924157659706.v4 and g3.dst=aggView6444798924157659706.v2;
create or replace view aggView3229017429067380500 as select src as v8, dst as v2 from Graph as g1;
create or replace view aggJoin3351792256748244526 as select src as v2 from Graph as g4, aggView3229017429067380500 where g4.dst=aggView3229017429067380500.v8 and g4.src=aggView3229017429067380500.v2;
create or replace view aggView783617149614649241 as select v2, COUNT(*) as annot from aggJoin3203165394358097526 group by v2;
create or replace view aggJoin5136271705453794053 as select annot from aggJoin3351792256748244526 join aggView783617149614649241 using(v2);
select SUM(annot) as v9 from aggJoin5136271705453794053;
