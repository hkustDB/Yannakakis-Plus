
##Reduce Phase: 

# Reduce0
# 2. minView
create or replace view minView596967615903227844 as select src as v12, max(dst) as mfR1863064879080212720 from Graph as g7 group by v12;
# 3. joinView
create or replace view joinView8611688414044861647 as select src as v10, dst as v12, mfR1863064879080212720 from Graph AS g6, minView596967615903227844 where g6.dst=minView596967615903227844.v12;

# Reduce1
# 1. orderView
create or replace view orderView7560627378248212003 as select v10, v12, mfR1863064879080212720, row_number() over (partition by v10 order by mfR1863064879080212720 DESC) as rn from joinView8611688414044861647;
# 2. minView
create or replace view minView9156965850495949295 as select v10, mfR1863064879080212720 as mfR5724814848865884073 from orderView7560627378248212003 where rn = 1;
# 3. joinView
create or replace view joinView6005416153783178 as select src as v8, dst as v10, mfR5724814848865884073 from Graph AS g5, minView9156965850495949295 where g5.dst=minView9156965850495949295.v10;

# Reduce2
# 2. minView
create or replace view minView4894396408588493725 as select dst as v2, min(src) as mfL359632707246644478 from Graph as g1 group by v2;
# 3. joinView
create or replace view joinView8606700144964001397 as select src as v2, dst as v4, mfL359632707246644478 from Graph AS g2, minView4894396408588493725 where g2.src=minView4894396408588493725.v2;

# Reduce3
# 2. minView
create or replace view minView877406840068299021 as select v4, min(mfL359632707246644478) as mfL4804821390240413086 from joinView8606700144964001397 group by v4;
# 3. joinView
create or replace view joinView3208792118315429131 as select src as v4, dst as v6, mfL4804821390240413086 from Graph AS g3, minView877406840068299021 where g3.src=minView877406840068299021.v4;

# Reduce4
# 2. minView
create or replace view minView617506377547283747 as select v6, min(mfL4804821390240413086) as mfL2935022209516733746 from joinView3208792118315429131 group by v6;
# 3. joinView
create or replace view joinView3305489130214670596 as select src as v6, dst as v8, mfL2935022209516733746 from Graph AS g4, minView617506377547283747 where g4.src=minView617506377547283747.v6;

# Reduce5
# 2. minView
create or replace view minView4559471297757607101 as select v8, min(mfL2935022209516733746) as mfL2241536208667265136 from joinView3305489130214670596 group by v8;
# 3. joinView
create or replace view joinView479232631938420904 as select v8, v10, mfR5724814848865884073, mfL2241536208667265136 from joinView6005416153783178 join minView4559471297757607101 using(v8) where mfL2241536208667265136<mfR5724814848865884073;

## Enumerate Phase: 

# Enumerate0
# 1. createSample
create or replace view sample2621582230896105157 as select * from orderView7560627378248212003 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn5801003314578980056 as select v10, max(rn) as mrn from joinView479232631938420904 join sample2621582230896105157 using(v10) where mfL2241536208667265136<mfR1863064879080212720 group by v10;
# 3. selectTarget
create or replace view target317963860127692121 as select v10, v12, mfR1863064879080212720 from orderView7560627378248212003 join maxRn5801003314578980056 using(v10) where rn < mrn + 5;
# 4. stageEnd
create or replace view end1242323648598163417 as select v8, v10, v12 from joinView479232631938420904 join target317963860127692121 using(v10) where mfL2241536208667265136<mfR1863064879080212720;
# Final result: 
select sum(distinct v8+v10+v12) from end1242323648598163417;

# drop view minView596967615903227844, joinView8611688414044861647, orderView7560627378248212003, minView9156965850495949295, joinView6005416153783178, minView4894396408588493725, joinView8606700144964001397, minView877406840068299021, joinView3208792118315429131, minView617506377547283747, joinView3305489130214670596, minView4559471297757607101, joinView479232631938420904, sample2621582230896105157, maxRn5801003314578980056, target317963860127692121, end1242323648598163417;
