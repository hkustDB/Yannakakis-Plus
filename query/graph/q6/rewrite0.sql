
##Reduce Phase: 

# Reduce0
# 0. Prepare
create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
# 1. orderView
create or replace view orderView1771159047205896174 as select v4, v6, v10, row_number() over (partition by v4 order by v6 DESC) as rn from g3;
# 2. minView
create or replace view minView6956208749819990114 as select v4, v6 as mfR8976698187123225188 from orderView1771159047205896174 where rn = 1;
# 3. joinView
create or replace view joinView5734769573008563347 as select src as v2, dst as v4, mfR8976698187123225188 from Graph AS g2, minView6956208749819990114 where g2.dst=minView6956208749819990114.v4;

# Reduce1
# 0. Prepare
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
# 1. orderView
create or replace view orderView8137267606785009878 as select v2, v4, mfR8976698187123225188, row_number() over (partition by v2 order by mfR8976698187123225188 DESC) as rn from joinView5734769573008563347;
# 2. minView
create or replace view minView2062568405986538802 as select v2, mfR8976698187123225188 as mfR983627908082266216 from orderView8137267606785009878 where rn = 1;
# 3. joinView
create or replace view joinView5078863996427019132 as select v7, v2, v8, mfR983627908082266216 from g1 join minView2062568405986538802 using(v2) where v8<mfR983627908082266216;

## Enumerate Phase: 

# Enumerate0
# 1. createSample
create or replace view sample7235815910819305868 as select * from orderView8137267606785009878 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn6836766552336869148 as select v2, max(rn) as mrn from joinView5078863996427019132 join sample7235815910819305868 using(v2) where v8<mfR8976698187123225188 group by v2;
# 3. selectTarget
create or replace view target6300810459395486153 as select v2, v4, mfR8976698187123225188 from orderView8137267606785009878 join maxRn6836766552336869148 using(v2) where rn < mrn + 5;
# 4. stageEnd
create or replace view end4488356382260877369 as select v7, v4, v8, v2, mfR8976698187123225188 from joinView5078863996427019132 join target6300810459395486153 using(v2) where v8<mfR8976698187123225188;

# Enumerate1
# 1. createSample
create or replace view sample623517867504631792 as select * from orderView1771159047205896174 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn3235929015929731581 as select v4, max(rn) as mrn from end4488356382260877369 join sample623517867504631792 using(v4) where v8<v6 group by v4;
# 3. selectTarget
create or replace view target5235244884893556884 as select v4, v6, v10 from orderView1771159047205896174 join maxRn3235929015929731581 using(v4) where rn < mrn + 5;
# 4. stageEnd
create or replace view end3945335587079293939 as select v7, v10, v4, v6, v8, v2 from end4488356382260877369 join target5235244884893556884 using(v4) where v8<v6;
# Final result: 
select sum(v7+v2+v4+v6+v8+v10) from end3945335587079293939;

# drop view g3, orderView1771159047205896174, minView6956208749819990114, joinView5734769573008563347, g1, orderView8137267606785009878, minView2062568405986538802, joinView5078863996427019132, sample7235815910819305868, maxRn6836766552336869148, target6300810459395486153, end4488356382260877369, sample623517867504631792, maxRn3235929015929731581, target5235244884893556884, end3945335587079293939;
