create or replace view aggView5848415601268571301 as select src as v4, COUNT(*) as annot from Graph as g3 group by src;
create or replace view aggJoin1673104764606300133 as select src as v2, dst as v4, annot from Graph as g2, aggView5848415601268571301 where g2.dst=aggView5848415601268571301.v4;
create or replace view aggView1165542238776941646 as select dst as v2, COUNT(*) as annot from Graph as g1 group by dst;
create or replace view aggJoin8119101060122100236 as select v2, v4, aggJoin1673104764606300133.annot * aggView1165542238776941646.annot as annot from aggJoin1673104764606300133 join aggView1165542238776941646 using(v2);
select v2,v4,annot as v7,annot as v7,annot as v7,annot as v7 from aggJoin8119101060122100236;
