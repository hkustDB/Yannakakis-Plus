
##Reduce Phase: 

# Reduce9
# 1. orderView
create or replace view orderView4101977639545108584 as select src as v1, dst as v2, row_number() over (partition by dst order by src) as rn from Graph as g1;
# 2. minView
create or replace view minView1657206707070501717 as select v2, v1 as mfL1605432356301685763 from orderView4101977639545108584 where rn = 1;
# 3. joinView
create or replace view joinView5668206997496019942 as select src as v2, dst as v4, mfL1605432356301685763 from Graph AS g2, minView1657206707070501717 where g2.src=minView1657206707070501717.v2;

# Reduce10
# 1. orderView
create or replace view orderView8564277158056638853 as select v2, v4, mfL1605432356301685763, row_number() over (partition by v4 order by mfL1605432356301685763) as rn from joinView5668206997496019942;
# 2. minView
create or replace view minView7022523292930531125 as select v4, mfL1605432356301685763 as mfL1849629003579795647 from orderView8564277158056638853 where rn = 1;
# 3. joinView
create or replace view joinView8570112626605670684 as select src as v4, dst as v6, mfL1849629003579795647 from Graph AS g3, minView7022523292930531125 where g3.src=minView7022523292930531125.v4;

# Reduce11
# 1. orderView
create or replace view orderView1453662991568601342 as select v4, v6, mfL1849629003579795647, row_number() over (partition by v6 order by mfL1849629003579795647) as rn from joinView8570112626605670684;
# 2. minView
create or replace view minView3599291166649085293 as select v6, mfL1849629003579795647 as mfL5964981585779707808 from orderView1453662991568601342 where rn = 1;
# 3. joinView
create or replace view joinView8387798958431810297 as select src as v6, dst as v8, mfL5964981585779707808 from Graph AS g4, minView3599291166649085293 where g4.src=minView3599291166649085293.v6 and mfL5964981585779707808<dst;

## Enumerate Phase: 

# Enumerate9
# 1. createSample
create or replace view sample3915607499331574576 as select * from orderView1453662991568601342 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn6355045049729848339 as select v6, max(rn) as mrn from joinView8387798958431810297 join sample3915607499331574576 using(v6) where mfL1849629003579795647<v8 group by v6;
# 3. selectTarget
create or replace view target6642626483055362191 as select v4, v6, mfL1849629003579795647 from orderView1453662991568601342 join maxRn6355045049729848339 using(v6) where rn < mrn + 5;
# 4. stageEnd
create or replace view end8364137371520269023 as select v6, v4, v8, mfL1849629003579795647 from joinView8387798958431810297 join target6642626483055362191 using(v6) where mfL1849629003579795647<v8;

# Enumerate10
# 1. createSample
create or replace view sample3857008146479411545 as select * from orderView8564277158056638853 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn6378392482367297482 as select v4, max(rn) as mrn from end8364137371520269023 join sample3857008146479411545 using(v4) where mfL1605432356301685763<v8 group by v4;
# 3. selectTarget
create or replace view target7518733430232777466 as select v2, v4, mfL1605432356301685763 from orderView8564277158056638853 join maxRn6378392482367297482 using(v4) where rn < mrn + 5;
# 4. stageEnd
create or replace view end6464139924510130511 as select v6, v4, v2, v8, mfL1605432356301685763 from end8364137371520269023 join target7518733430232777466 using(v4) where mfL1605432356301685763<v8;

# Enumerate11
# 1. createSample
create or replace view sample872146505320710397 as select * from orderView4101977639545108584 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn3063479032806654737 as select v2, max(rn) as mrn from end6464139924510130511 join sample872146505320710397 using(v2) where v1<v8 group by v2;
# 3. selectTarget
create or replace view target6203850004561848520 as select v1, v2 from orderView4101977639545108584 join maxRn3063479032806654737 using(v2) where rn < mrn + 5;
# 4. stageEnd
create or replace view end6961458380514712 as select v6, v1, v4, v2, v8 from end6464139924510130511 join target6203850004561848520 using(v2) where v1<v8;
# Final result: 
select sum(v1+v2+v4+v6+v8) from end6961458380514712;

# drop view orderView4101977639545108584, minView1657206707070501717, joinView5668206997496019942, orderView8564277158056638853, minView7022523292930531125, joinView8570112626605670684, orderView1453662991568601342, minView3599291166649085293, joinView8387798958431810297, sample3915607499331574576, maxRn6355045049729848339, target6642626483055362191, end8364137371520269023, sample3857008146479411545, maxRn6378392482367297482, target7518733430232777466, end6464139924510130511, sample872146505320710397, maxRn3063479032806654737, target6203850004561848520, end6961458380514712;
