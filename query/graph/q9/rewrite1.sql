create or replace view aggView7487878264601271114 as select src as v8, dst as v2 from Graph as g1;
create or replace view aggJoin3976081681987681546 as select src as v2 from Graph as g4, aggView7487878264601271114 where g4.dst=aggView7487878264601271114.v8 and g4.src=aggView7487878264601271114.v2;
create or replace view aggView6566647551438076815 as select dst as v4, src as v2 from Graph as g2;
create or replace view aggJoin4548782838681701764 as select dst as v2 from Graph as g3, aggView6566647551438076815 where g3.src=aggView6566647551438076815.v4 and g3.dst=aggView6566647551438076815.v2;
create or replace view aggView2733237354766689127 as select v2, COUNT(*) as annot from aggJoin3976081681987681546 group by v2;
create or replace view aggJoin285499683082441262 as select annot from aggJoin4548782838681701764 join aggView2733237354766689127 using(v2);
select SUM(annot) as v9 from aggJoin285499683082441262;
