create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src and v8<Graph.dst;
create or replace view semiJoinView7584412751491288548 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select v2 from g1);
create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src and v10<Graph.src;
create or replace view semiJoinView3587010335412772735 as select v4, v6, v10 from g3 where (v4) in (select v4 from semiJoinView7584412751491288548);
create or replace view semiEnum2571389745371966891 as select v2, v10, v6, v4 from semiJoinView3587010335412772735 join semiJoinView7584412751491288548 using(v4);
create or replace view semiEnum5999038409244953590 as select v2, v8, v6, v10, v7, v4 from semiEnum2571389745371966891 join g1 using(v2);
select sum(v7+v2+v4+v6+v8+v10) from semiEnum5999038409244953590;
