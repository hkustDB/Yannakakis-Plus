
##Reduce Phase: 

# Reduce6
# 1. orderView
create or replace view orderView616263158836599134 as select src as v1, dst as v2, row_number() over (partition by dst order by src) as rn from Graph as g1;
# 2. minView
create or replace view minView5606148319558978799 as select v2, v1 as mfL4369865829045039627 from orderView616263158836599134 where rn = 1;
# 3. joinView
create or replace view joinView6241897077009745297 as select src as v2, dst as v4, mfL4369865829045039627 from Graph AS g2, minView5606148319558978799 where g2.src=minView5606148319558978799.v2;

# Reduce7
# 1. orderView
create or replace view orderView5339026493875820798 as select src as v6, dst as v8, row_number() over (partition by src order by dst DESC) as rn from Graph as g4;
# 2. minView
create or replace view minView7232484606766666291 as select v6, v8 as mfR1444315342025542860 from orderView5339026493875820798 where rn = 1;
# 3. joinView
create or replace view joinView2373957867199390861 as select src as v4, dst as v6, mfR1444315342025542860 from Graph AS g3, minView7232484606766666291 where g3.dst=minView7232484606766666291.v6;

# Reduce8
# 1. orderView
create or replace view orderView5893002550505850922 as select v4, v6, mfR1444315342025542860, row_number() over (partition by v4 order by mfR1444315342025542860 DESC) as rn from joinView2373957867199390861;
# 2. minView
create or replace view minView8759691248752430320 as select v4, mfR1444315342025542860 as mfR6083772684262473153 from orderView5893002550505850922 where rn = 1;
# 3. joinView
create or replace view joinView3299417169218736440 as select v2, v4, mfL4369865829045039627, mfR6083772684262473153 from joinView6241897077009745297 join minView8759691248752430320 using(v4) where mfL4369865829045039627<mfR6083772684262473153;

## Enumerate Phase: 

# Enumerate6
# 1. createSample
create or replace view sample8609572238980340775 as select * from orderView5893002550505850922 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn3085462777053716747 as select v4, max(rn) as mrn from joinView3299417169218736440 join sample8609572238980340775 using(v4) where mfL4369865829045039627<mfR1444315342025542860 group by v4;
# 3. selectTarget
create or replace view target4042234086485541268 as select v4, v6, mfR1444315342025542860 from orderView5893002550505850922 join maxRn3085462777053716747 using(v4) where rn < mrn + 5;
# 4. stageEnd
create or replace view end514536734971795184 as select v6, v4, v2, mfL4369865829045039627, mfR1444315342025542860 from joinView3299417169218736440 join target4042234086485541268 using(v4) where mfL4369865829045039627<mfR1444315342025542860;

# Enumerate7
# 1. createSample
create or replace view sample110783945975858787 as select * from orderView5339026493875820798 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn6659530636661064880 as select v6, max(rn) as mrn from end514536734971795184 join sample110783945975858787 using(v6) where mfL4369865829045039627<v8 group by v6;
# 3. selectTarget
create or replace view target5058848355879092661 as select v6, v8 from orderView5339026493875820798 join maxRn6659530636661064880 using(v6) where rn < mrn + 5;
# 4. stageEnd
create or replace view end3559981416361021158 as select v6, v4, v2, v8, mfL4369865829045039627 from end514536734971795184 join target5058848355879092661 using(v6) where mfL4369865829045039627<v8;

# Enumerate8
# 1. createSample
create or replace view sample8642279066309939785 as select * from orderView616263158836599134 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn1165106878478096806 as select v2, max(rn) as mrn from end3559981416361021158 join sample8642279066309939785 using(v2) where v1<v8 group by v2;
# 3. selectTarget
create or replace view target3066159012792175891 as select v1, v2 from orderView616263158836599134 join maxRn1165106878478096806 using(v2) where rn < mrn + 5;
# 4. stageEnd
create or replace view end3809693430078597638 as select v6, v1, v4, v2, v8 from end3559981416361021158 join target3066159012792175891 using(v2) where v1<v8;
# Final result: 
select sum(v1+v2+v4+v6+v8) from end3809693430078597638;

# drop view orderView616263158836599134, minView5606148319558978799, joinView6241897077009745297, orderView5339026493875820798, minView7232484606766666291, joinView2373957867199390861, orderView5893002550505850922, minView8759691248752430320, joinView3299417169218736440, sample8609572238980340775, maxRn3085462777053716747, target4042234086485541268, end514536734971795184, sample110783945975858787, maxRn6659530636661064880, target5058848355879092661, end3559981416361021158, sample8642279066309939785, maxRn1165106878478096806, target3066159012792175891, end3809693430078597638;
