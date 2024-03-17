create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
create or replace view g3Aux32 as select v4, v6, v10 from g3;
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
create or replace view minView4962803192643214411 as select v2, v8 as mfL3019702247407501155 from g1;
create or replace view joinView5724638360322176073 as select src as v2, dst as v4, mfL3019702247407501155 from Graph AS g2, minView4962803192643214411 where g2.src=minView4962803192643214411.v2;
create or replace view minView4017255592096208111 as select v4, mfL3019702247407501155 as mfL606813830910008169 from joinView5724638360322176073;
create or replace view joinView8985037696760870903 as select v4, v6 from g3Aux32 join minView4017255592096208111 using(v4) where mfL606813830910008169<v10;
create or replace view res as select distinct v4, v6 from joinView8985037696760870903;
select sum(v4+v6) from res;
