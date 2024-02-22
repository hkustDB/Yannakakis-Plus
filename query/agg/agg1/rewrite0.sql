create or replace view aggView1246262190686151539 as select src as v8, COUNT(*) as annot from Graph as g5 group by src;
create or replace view aggJoin4495106187441106489 as select src as v6, dst as v8, annot from Graph as g4, aggView1246262190686151539 where g4.dst=aggView1246262190686151539.v8;
create or replace view aggView487202855704080344 as select v6, SUM((v8 + v6) * annot) as v12, SUM(annot) as annot from aggJoin4495106187441106489 group by v6;
create or replace view aggJoin6862396303270918130 as select src as v4, dst as v6, v12, annot from Graph as g3, aggView487202855704080344 where g3.dst=aggView487202855704080344.v6;
create or replace view aggView5429058852963728797 as select v4, SUM(v12) as v12, SUM(annot) as annot from aggJoin6862396303270918130 group by v4;
create or replace view aggJoin8548842867640410752 as select src as v2, dst as v4, v12, annot from Graph as g2, aggView5429058852963728797 where g2.dst=aggView5429058852963728797.v4;
create or replace view aggView4518074769899573458 as select dst as v2, COUNT(*) as annot from Graph as g1 group by dst;
create or replace view aggJoin3910970543037749030 as select v2, v4, v12*aggView4518074769899573458.annot as v12 from aggJoin8548842867640410752 join aggView4518074769899573458 using(v2);
select v2,v4,v12 from aggJoin3910970543037749030;
