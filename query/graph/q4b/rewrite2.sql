create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
create or replace view aggView6718043236712490276 as select v2, COUNT(*) as annot from g1 group by v2;
create or replace view aggJoin4867419419177328536 as select dst as v4, annot from Graph as g2, aggView6718043236712490276 where g2.src=aggView6718043236712490276.v2;
create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
create or replace view aggView2700346437942133580 as select v4, COUNT(*) as annot from g3 group by v4;
create or replace view aggJoin6654050743405211187 as select aggJoin4867419419177328536.annot * aggView2700346437942133580.annot as annot from aggJoin4867419419177328536 join aggView2700346437942133580 using(v4);
select SUM(annot) as v11 from aggJoin6654050743405211187;
