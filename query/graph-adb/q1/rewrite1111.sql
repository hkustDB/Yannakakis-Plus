create or replace view g1 as select g1.src as v1, g1.dst as v2, v8 from Graph g1, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where c1.src = g1.src;
create or replace view g2 as select g2.src as v2, g2.dst as v4 from Graph g2;
create or replace view g3 as select g3.src as v4, g3.dst as v6, v10 from Graph g3, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c1 where c1.src = g3.dst;

create or replace view f1 as select v2, min(v8) as MFL from g1 group by v2;
create or replace view f2 as select v2, v4, MFL from g2 join f1 using(v2);
create or replace view f3 as select v4, min(MFL) as MFL2 from f2 group by v4;
create or replace view f4 as select v4, v6, v10 from g3 join f3 using(v4) where MFL2 < v10;

create or replace view f4_agg as select v4, max(v10) as upper from f4 group by v4;
create or replace view b1_semi as select v2, v4, MFL from f2 join f4_agg using(v4) where MFL < upper;
create or replace view b1 as select v2, v4, v6, v10 from b1_semi join f4 using(v4) where MFL < v10;

create or replace view b1_agg as select v2, max(v10) as upper from b1 group by v2;
create or replace view b2_semi as select g1.* from g1 join b1_agg using(v2) where v8 < upper;
create or replace view b2 as select v1, v2, v4, v8, v10 from b2_semi join b1 using(v2) where v8 < v10;
select sum(v1 + v2 + v4 + v8 + v10) from b2;