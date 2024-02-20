
##Reduce Phase: 

# Reduce4
# 0. Prepare
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
# 1. orderView
create or replace view orderView8922066891963641353 as select v7, v2, v8, row_number() over (partition by v2 order by v8) as rn from g1;
# 2. minView
create or replace view minView1958879466732739737 as select v2, v8 as mfL8109785069944585308 from orderView8922066891963641353 where rn = 1;
# 3. joinView
create or replace view joinView1411485765728561023 as select src as v2, dst as v4, mfL8109785069944585308 from Graph AS g2, minView1958879466732739737 where g2.src=minView1958879466732739737.v2;

# Reduce5
# 0. Prepare
create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
# 1. orderView
create or replace view orderView2563215819913736592 as select v4, v6, v10, row_number() over (partition by v4 order by v6 DESC) as rn from g3;
# 2. minView
create or replace view minView1062334730525207334 as select v4, v6 as mfR6969316590222219576 from orderView2563215819913736592 where rn = 1;
# 3. joinView
create or replace view joinView2529503018994415935 as select v2, v4, mfL8109785069944585308, mfR6969316590222219576 from joinView1411485765728561023 join minView1062334730525207334 using(v4) where mfL8109785069944585308<mfR6969316590222219576;

## Enumerate Phase: 

# Enumerate4
# 1. createSample
create or replace view sample1791675200532545618 as select * from orderView2563215819913736592 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn5919614340399991207 as select v4, max(rn) as mrn from joinView2529503018994415935 join sample1791675200532545618 using(v4) where mfL8109785069944585308<v6 group by v4;
# 3. selectTarget
create or replace view target319257583127541449 as select v4, v6, v10 from orderView2563215819913736592 join maxRn5919614340399991207 using(v4) where rn < mrn + 5;
# 4. stageEnd
create or replace view end3902938935040847860 as select v10, v4, v6, v2, mfL8109785069944585308 from joinView2529503018994415935 join target319257583127541449 using(v4) where mfL8109785069944585308<v6;

# Enumerate5
# 1. createSample
create or replace view sample6665183044683783408 as select * from orderView8922066891963641353 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn5276257019200051990 as select v2, max(rn) as mrn from end3902938935040847860 join sample6665183044683783408 using(v2) where v8<v6 group by v2;
# 3. selectTarget
create or replace view target8579731980399226975 as select v7, v2, v8 from orderView8922066891963641353 join maxRn5276257019200051990 using(v2) where rn < mrn + 5;
# 4. stageEnd
create or replace view end4348427396655270723 as select v7, v10, v4, v6, v8, v2 from end3902938935040847860 join target8579731980399226975 using(v2) where v8<v6;
# Final result: 
select sum(v7+v2+v4+v6+v8+v10) from end4348427396655270723;

# drop view g1, orderView8922066891963641353, minView1958879466732739737, joinView1411485765728561023, g3, orderView2563215819913736592, minView1062334730525207334, joinView2529503018994415935, sample1791675200532545618, maxRn5919614340399991207, target319257583127541449, end3902938935040847860, sample6665183044683783408, maxRn5276257019200051990, target8579731980399226975, end4348427396655270723;
