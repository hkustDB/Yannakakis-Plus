
drop view if exists g3 CASCADE;
drop view if exists semiUp2888979063151549454 CASCADE;
drop view if exists g1 CASCADE;
drop view if exists semiUp1506119180625094627 CASCADE;
drop view if exists semiDown5140684049181280502 CASCADE;
drop view if exists semiDown8951418430866816276 CASCADE;
drop view if exists joinView5357089972968636351 CASCADE;
drop view if exists joinView2228893725264769449 CASCADE;
create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
create or replace view semiUp2888979063151549454 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select v4 from g3);
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src and v8<2;
create or replace view semiUp1506119180625094627 as select v2, v4 from semiUp2888979063151549454 where (v2) in (select v2 from g1);
create or replace view semiDown5140684049181280502 as select v7, v2, v8 from g1 where (v2) in (select v2 from semiUp1506119180625094627);
create or replace view semiDown8951418430866816276 as select v4, v6, v10 from g3 where (v4) in (select v4 from semiUp1506119180625094627);
create or replace view joinView5357089972968636351 as select v2, v4, v7, v8 from semiUp1506119180625094627 join semiDown5140684049181280502 using(v2);
create or replace view joinView2228893725264769449 as select v2, v4, v7, v8, v6, v10 from joinView5357089972968636351 join semiDown8951418430866816276 using(v4);
/*+QUERY_TIMEOUT=86400000*/select sum(v2+v4+v7+v8+v6+v10) from joinView2228893725264769449;
