create or replace view aggView1190978271656221652 as select dst as v2, COUNT(*) as annot from Graph as g1 group by dst;
create or replace view aggJoin8821205223918702953 as select src as v2, dst as v4, annot from Graph as g2, aggView1190978271656221652 where g2.src=aggView1190978271656221652.v2;
create or replace view semiJoinView3562929600708591174 as select src as v4, dst as v6, dst as v7 from Graph AS g3 where (src) in (select v4 from aggJoin8821205223918702953);
# +. SemiEnumerate
create or replace view semiEnum45593190156143615 as select v6, v4, v2, v7*aggJoin8821205223918702953.annot as v7 from semiJoinView3562929600708591174 join aggJoin8821205223918702953 using(v4);
select v2,v4,v6,v7,v8 from semiEnum45593190156143615;
