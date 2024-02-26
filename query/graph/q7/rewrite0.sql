create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src and v8<Graph.dst;
create or replace view semiJoinView2776714715599190402 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select v2 from g1);
create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src and v10<Graph.src;
create or replace view semiJoinView8165854388528270015 as select v4, v6, v10 from g3 where (v4) in (select v4 from semiJoinView2776714715599190402);
create or replace view semiEnum5440310001050102906 as select v6, v4, v2, v10 from semiJoinView8165854388528270015 join semiJoinView2776714715599190402 using(v4);
create or replace view semiEnum8145927589356539693 as select v8, v6, v4, v7, v2, v10 from semiEnum5440310001050102906 join g1 using(v2);
select * from semiEnum8145927589356539693;
