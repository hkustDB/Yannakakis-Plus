create or replace view g1 as select g1.src as v1, g1.dst as v2, v8 from Graph g1, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where c1.src = g1.src;
create or replace view g2 as select g2.src as v2, g2.dst as v4 from Graph g2;
create or replace view g3 as select g3.src as v4, g2.dst as v6, v10 from Graph g3, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c1 where c1.src = g3.dst;

create or replace view orderView1 as select v1, v2, v8, row_number() over (partition by v2 order by v8) as rn from g1;
create or replace view minView1 as select v2, v8 as MFL from orderView1 where rn = 1;
create or replace view joinView1 as select v2, v4, MFL from g2 join minView1 using(v2);

create or replace view orderView2 as select v4, v6, v10, row_number() over (partition by v4 order by v10 DESC) as rn from g3;
create or replace view minView2 as select v4, v10 as MFR from orderView2 where rn = 1;
create or replace view joinView2 as select v2, v4, MFL from joinView1 join minView2 using(v4) where MFL < MFR;

create or replace view order2_0 as select * from orderView2 where rn <= 64;
create or replace view res2_0 as select v2, v4, v6, v10, rn, MFL from joinView2 join order2_0 using(v4) where MFL < v10;
create or replace view border0 as select v2, v4, MFL from res2_0 where rn = 64;
create or replace view order2_1 as select * from orderView2 where 64 < rn and rn <= 4096;
create or replace view res2_1 as select v2, v4, v6, v10 from border0 join order2_1 using(v4) where MFL < v10;
create or replace view res2 as select v2, v4, v6, v10 from res2_1 union all select v2, v4, v6, v10 from res2_0;

create or replace view order1_0 as select * from orderView1 where rn <= 64;
create or replace view res1_0 as select v1, v2, v4, v6, v8, v10, rn from res2 join order1_0 using(v2) where v8 < v10;
create or replace view border1_0 as select v2, v4, v6, v10 from res1_0 where rn = 64;
create or replace view order1_1 as select * from orderView1 where 64 < rn and rn <= 4096;
create or replace view res1_1 as select v1, v2, v4, v6, v8, v10 from border1_0 join order1_1 using(v2) where v8 < v10;
create or replace view res1 as select v1, v2, v4, v8, v10 from res1_0 union all select v1, v2, v4, v8, v10 from res1_1;

select * from res1;