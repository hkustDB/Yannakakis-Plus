create or replace view aggView3545317075034756324 as select dst as v2, SUM(src) as v9, COUNT(*) as annot from Graph as g1 group by dst;
create or replace view aggJoin7290987517241741419 as select src as v2, dst as v4, v9, annot from Graph as g2, aggView3545317075034756324 where g2.src=aggView3545317075034756324.v2 and src<dst;
create or replace view semiJoinView3757048318144890367 as select src as v4, dst as v6 from Graph AS g3 where (dst) in (select (src) from Graph AS g4);
create or replace view semiJoinView8606044879485978766 as select distinct v2, v4, v9, annot from aggJoin7290987517241741419 where (v4) in (select (v4) from semiJoinView3757048318144890367);
create or replace view semiEnum7531092095618260774 as select distinct v6, v9, v2, v4, annot from semiJoinView8606044879485978766 join semiJoinView3757048318144890367 using(v4);
create or replace view semiEnum6861377965521248468 as select dst as v8, v9, v2, annot from semiEnum7531092095618260774, Graph as g4 where g4.src=semiEnum7531092095618260774.v6;
select v2,v8,SUM(v9) as v9 from semiEnum6861377965521248468 group by v2, v8;
