
##Reduce Phase: 

# Reduce4
# 0. Prepare
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
# 1. orderView
create or replace view orderView6811607060271611238 as select v7, v2, v8, row_number() over (partition by v2 order by v8 DESC) as rn from g1;
# 2. minView
create or replace view minView3425756456454570828 as select v2, v8 as mfR6561152496987081519 from orderView6811607060271611238 where rn = 1;
# 3. joinView
create or replace view joinView7127836914114738798 as select src as v2, dst as v4, mfR6561152496987081519 from Graph AS g2, minView3425756456454570828 where g2.src=minView3425756456454570828.v2;

# Reduce5
# 0. Prepare
create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
# 1. orderView
create or replace view orderView3442539685351118384 as select v2, v4, mfR6561152496987081519, row_number() over (partition by v4 order by mfR6561152496987081519 DESC) as rn from joinView7127836914114738798;
# 2. minView
create or replace view minView7286863847013963900 as select v4, mfR6561152496987081519 as mfR4997074911350730770 from orderView3442539685351118384 where rn = 1;
# 3. joinView
create or replace view joinView1812891424105106080 as select v4, v6, v10, mfR4997074911350730770 from g3 join minView7286863847013963900 using(v4) where v10<=mfR4997074911350730770;

## Enumerate Phase: 

# Enumerate4
# 1. createSample
create or replace view sample3166926130703593234 as select * from orderView3442539685351118384 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn3619483450971055586 as select v4, max(rn) as mrn from joinView1812891424105106080 join sample3166926130703593234 using(v4) where v10<=mfR6561152496987081519 group by v4;
# 3. selectTarget
create or replace view target8403569806110125248 as select v2, v4, mfR6561152496987081519 from orderView3442539685351118384 join maxRn3619483450971055586 using(v4) where rn < mrn + 5;
# 4. stageEnd
create or replace view end1881167160622194961 as select v4, v6, v2, v10, mfR6561152496987081519 from joinView1812891424105106080 join target8403569806110125248 using(v4) where v10<=mfR6561152496987081519;

# Enumerate5
# 1. createSample
create or replace view sample4661391358358839995 as select * from orderView6811607060271611238 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn3185117877888504228 as select v2, max(rn) as mrn from end1881167160622194961 join sample4661391358358839995 using(v2) where v10<=v8 group by v2;
# 3. selectTarget
create or replace view target8720015189525012456 as select v7, v2, v8 from orderView6811607060271611238 join maxRn3185117877888504228 using(v2) where rn < mrn + 5;
# 4. stageEnd
create or replace view end2909657977862653396 as select v4, v8, v7, v6, v2, v10 from end1881167160622194961 join target8720015189525012456 using(v2) where v10<=v8;
# Final result: 
select sum(v7+v2+v4+v6+v8+v10) from end2909657977862653396;

# drop view g1, orderView6811607060271611238, minView3425756456454570828, joinView7127836914114738798, g3, orderView3442539685351118384, minView7286863847013963900, joinView1812891424105106080, sample3166926130703593234, maxRn3619483450971055586, target8403569806110125248, end1881167160622194961, sample4661391358358839995, maxRn3185117877888504228, target8720015189525012456, end2909657977862653396;
