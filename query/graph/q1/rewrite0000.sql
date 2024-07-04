create or replace view g1 as select g1.src as v1, g1.dst as v2, v8 from Graph g1, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where c1.src = g1.src;
create or replace view g2 as select g2.src as v2, g2.dst as v4 from Graph g2;
create or replace view g3 as select g3.src as v4, g3.dst as v6, v10 from Graph g3, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c1 where c1.src = g3.dst;

create or replace view f3 as select v2, min(v8) as mf1 from g1 group by v2;
create or replace view f4 as select v2, v4, mf1 from g2 join f3 using(v2);
create or replace view f5 as select v4, max(v10) as mf2 from g3 group by v4;
create or replace view f6 as select v2, v4, mf1 from f4 join f5 using(v4) where mf1 < mf2;

create or replace view f6_agg as select v4, min(mf1) as lower from f6 group by v4;
create or replace view b1_semi as select v4, v6, v10 from g3 join f6_agg using(v4) where lower < v10;
create or replace view b1 as select v2, v4, v6, v10 from f6 join b1_semi using(v4) where mf1 < v10;

create or replace view b1_agg as select v2, max(v10) as upper from b1 group by v2;
create or replace view b2_semi as select v1, v2, v8 from g1 join b1_agg using(v2) where v8 < upper;
create or replace view b2 as select v1, v2, v4, v6, v8, v10 from b1 join b2_semi using(v2) where v8 < v10;
select * from b2;