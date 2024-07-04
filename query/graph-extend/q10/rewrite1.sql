create or replace view aggView7715644344417945573 as select src as v8, dst as v2 from Graph as g1;
create or replace view aggJoin3102453999819907410 as select src as v2 from Graph as g4, aggView7715644344417945573 where g4.dst=aggView7715644344417945573.v8 and g4.src=aggView7715644344417945573.v2;
create or replace view aggView3490864628352942817 as select dst as v4, src as v2 from Graph as g2;
create or replace view aggJoin2198137123952186334 as select dst as v2 from Graph as g3, aggView3490864628352942817 where g3.src=aggView3490864628352942817.v4 and g3.dst=aggView3490864628352942817.v2;
create or replace view aggView2266362952412223058 as select v2, COUNT(*) as annot from aggJoin3102453999819907410 group by v2;
create or replace view aggJoin7014862984296612613 as select annot from aggJoin2198137123952186334 join aggView2266362952412223058 using(v2);
/*+QUERY_TIMEOUT=86400000*/select SUM(annot) as v9 from aggJoin7014862984296612613;
