
drop view if exists g3 CASCADE;
drop view if exists semiUp5158477671496740338 CASCADE;
drop view if exists g1 CASCADE;
drop view if exists semiUp7644701936707842368 CASCADE;
drop view if exists semiDown7967174396486732787 CASCADE;
drop view if exists semiDown6861813274736507022 CASCADE;
drop view if exists joinView3426361677249748792 CASCADE;
drop view if exists joinView3099151450942935383 CASCADE;
create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
create or replace view semiUp5158477671496740338 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select v4 from g3);
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src and v8<2;
create or replace view semiUp7644701936707842368 as select v7, v2, v8 from g1 where (v2) in (select v2 from semiUp5158477671496740338);
create or replace view semiDown7967174396486732787 as select v2, v4 from semiUp5158477671496740338 where (v2) in (select v2 from semiUp7644701936707842368);
create or replace view semiDown6861813274736507022 as select v4, v6, v10 from g3 where (v4) in (select v4 from semiDown7967174396486732787);
create or replace view joinView3426361677249748792 as select v2, v4, v6, v10 from semiDown7967174396486732787 join semiDown6861813274736507022 using(v4);
create or replace view joinView3099151450942935383 as select v7, v2, v8, v4, v6, v10 from semiUp7644701936707842368 join joinView3426361677249748792 using(v2);
/*+QUERY_TIMEOUT=86400000*/select sum(v7+v2+v8+v4+v6+v10) from joinView3099151450942935383;
