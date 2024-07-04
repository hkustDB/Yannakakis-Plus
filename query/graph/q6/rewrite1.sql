create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8, v10 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.src = c1.src and Graph.src = c2.src and v8<v10;
create or replace view semiJoinView1219377327836335505 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select (v2) from g1);
create or replace view semiJoinView8655412486425745632 as select distinct src as v4, dst as v6 from Graph AS g3 where (src) in (select (v4) from semiJoinView1219377327836335505);
create or replace view semiEnum5420140253749628836 as select distinct v2, v6 from semiJoinView8655412486425745632 join semiJoinView1219377327836335505 using(v4);
create or replace view semiEnum481559836265824980 as select v7, v6, v10, v8 from semiEnum5420140253749628836 join g1 using(v2);
select distinct v7, v6, v8, v10 from semiEnum481559836265824980;
