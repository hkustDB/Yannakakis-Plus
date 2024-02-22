create or replace view aggView271081297238446492 as select src as v6, COUNT(*) as annot, dst as v8 from Graph as g4 group by src,dst;
create or replace view aggJoin1393153546430354174 as select src as v4, dst as v6, v8, annot from Graph as g3, aggView271081297238446492 where g3.dst=aggView271081297238446492.v6;
create or replace view aggView8091800685886875274 as select v4, SUM(v6 * annot) as v9, SUM(annot) as annot, v8 from aggJoin1393153546430354174 group by v4,v8;
create or replace view aggJoin7733439896954471764 as select src as v2, v9, v8, annot from Graph as g2, aggView8091800685886875274 where g2.dst=aggView8091800685886875274.v4;
create or replace view aggView4343656626935352819 as select v2, SUM(v9) as v9, SUM(annot) as annot, v8 from aggJoin7733439896954471764 group by v2,v8;
create or replace view aggJoin5790690784621785765 as select v2, v9, v8, annot from aggView4343656626935352819;
create or replace view aggView8213557475881972616 as select dst as v2, src as v1 from Graph as g1 where src IN (1,2) group by dst,src;
create or replace view aggJoin7561876339225014327 as select v2, v9 from aggJoin5790690784621785765 join aggView8213557475881972616 using(v2) where v1 < v8;
select v2,v9 from aggJoin7561876339225014327;
