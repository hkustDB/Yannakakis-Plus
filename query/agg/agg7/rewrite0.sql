create or replace view aggView5056148239402042910 as select src as v4, SUM(dst) as v7, COUNT(*) as annot from Graph as g3 group by src;
create or replace view aggJoin278506780439878683 as select src as v2, v7, annot from Graph as g2, aggView5056148239402042910 where g2.dst=aggView5056148239402042910.v4;
create or replace view aggView5847246678164377488 as select v2, SUM(v7) as v7, SUM(annot) as annot from aggJoin278506780439878683 group by v2;
create or replace view aggJoin8818603609025622631 as select v2, v7, annot from aggView5847246678164377488;
create or replace view aggView4358415494979552412 as select dst as v2 from Graph as g1 group by dst;
create or replace view aggJoin7702983421923384012 as select v2, v7*aggView4358415494979552412.annot as v7 from aggJoin8818603609025622631 join aggView4358415494979552412 using(v2);
select v2,v7 from aggJoin7702983421923384012;
