create or replace view bag6323 as select g1.dst as v2, g3.src as v4, g3.dst as v6 from Graph as g3, Graph as g1 where g3.dst=g1.src;
create or replace view bag6321 as select g7.dst as v12, g7.src as v2, g2.dst as v4 from Graph as g7, Graph as g2 where g7.src=g2.src;
create or replace view semiJoinView2354715356542457753 as select v12, v2, v4 from bag6321 where (v2, v4) in (select (v2, v4) from bag6323);
create or replace view bag6322 as select g6.src as v10, g6.dst as v12, g5.src as v8 from Graph as g6, Graph as g5, Graph as g4 where g6.src=g5.dst and g5.src=g4.dst and g4.src=g6.dst;
create or replace view semiJoinView6406278483200741917 as select v12, v2, v4 from semiJoinView2354715356542457753 where (v12) in (select (v12) from bag6322);
create or replace view bag6321Aux21 as select v4 from semiJoinView6406278483200741917;
create or replace view res as select distinct v4 from bag6321Aux21;
/*+QUERY_TIMEOUT=86400000*/select SUM(v4) from res;
