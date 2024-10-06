create temp table g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src and v8<5;
create temp table g2 as select Graph.src as v2, Graph.dst as v4, v12 from Graph, (SELECT src, COUNT(*) AS v12 FROM Graph GROUP BY src) AS c3 where Graph.src = c3.src;
create temp table g3 as select Graph.src as v4, Graph.dst as v9, v10, v14 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2, (SELECT dst, COUNT(*) AS v14 FROM Graph GROUP BY dst) AS c4 where Graph.dst = c2.src and Graph.dst = c4.dst;
create temp table semiUp3517572420805207803 as select v4, v9, v10, v14 from g3 where (v4) in (select v4 from semiUp955750110907120044);
create temp table semiDown2802933996917154775 as select v2, v4, v12 from semiUp955750110907120044 where (v4) in (select v4 from semiUp3517572420805207803);
create temp table semiDown4036467304996317791 as select v7, v2, v8 from g1 where (v2) in (select v2 from semiDown2802933996917154775);
create temp table joinView786322991104552459 as select v2, v4, v12, v7, v8 from semiDown2802933996917154775 join semiDown4036467304996317791 using(v2);
create temp table joinView7833727801962842095 as select v4, v9, v10, v14, v2, v12, v7, v8 from semiUp3517572420805207803 join joinView786322991104552459 using(v4);
select v7, v2, v4, v9, v8, v10, v12, v14 from joinView7833727801962842095;
