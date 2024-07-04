create or replace view bag6311 as select g2.src as v2, g3.src as v4, g3.dst as v6 from Graph as g3, Graph as g2, Graph as g1 where g3.src=g2.dst and g2.src=g1.dst and g1.src=g3.dst;
create or replace view aggView4986632242884710001 as select v2, COUNT(*) as annot from bag6311 group by v2;
create or replace view aggJoin5789382530991781260 as select dst as v12, annot from Graph as g7, aggView4986632242884710001 where g7.src=aggView4986632242884710001.v2;
create or replace view bag6312 as select g6.src as v10, g6.dst as v12, g5.src as v8 from Graph as g6, Graph as g5, Graph as g4 where g6.src=g5.dst and g5.src=g4.dst and g4.src=g6.dst;
create or replace view aggView7757614425463603169 as select v12, COUNT(*) as annot from bag6312 group by v12;
create or replace view aggJoin2591164005033454880 as select aggJoin5789382530991781260.annot * aggView7757614425463603169.annot as annot from aggJoin5789382530991781260 join aggView7757614425463603169 using(v12);
/*+QUERY_TIMEOUT=86400000*/select SUM(annot) as v15 from aggJoin2591164005033454880;
