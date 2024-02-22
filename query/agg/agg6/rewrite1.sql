create or replace view aggView5820089301299016678 as select SUM(dst) as v11, COUNT(*) as annot from Graph as g5 group by ;
create or replace view aggJoin3043974973324739395 as select src as v2, dst as v4, v11, annot from Graph as g2, aggView5820089301299016678;
create or replace view aggView2169366095821765499 as select dst as v2, COUNT(*) as annot from Graph as g1 group by dst;
create or replace view aggJoin5895539630557128164 as select v2, v4, v11*aggView2169366095821765499.annot as v11, aggJoin3043974973324739395.annot * aggView2169366095821765499.annot as annot from aggJoin3043974973324739395 join aggView2169366095821765499 using(v2);
create or replace view aggView8369304734553624648 as select src as v6, COUNT(*) as annot from Graph as g4 group by src;
create or replace view aggJoin7883667375413688286 as select src as v4, dst as v6, annot from Graph as g3, aggView8369304734553624648 where g3.dst=aggView8369304734553624648.v6;
create or replace view semiJoinView9183013810560500650 as select v2, v4, v11, annot from aggJoin5895539630557128164 where (v4) in (select v4 from aggJoin7883667375413688286);
# +. SemiEnumerate
create or replace view semiEnum5596357503885391636 as select v11*aggJoin7883667375413688286.annot as v11, v6, v4, v2 from semiJoinView9183013810560500650 join aggJoin7883667375413688286 using(v4);
select v2,v4,v6,SUM(v11) as v11 from semiEnum5596357503885391636 group by v2, v4, v6;
