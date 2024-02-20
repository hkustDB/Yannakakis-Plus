
##Reduce Phase: 

# Reduce3
# 1. orderView
create or replace view orderView1445365624903736685 as select src as v6, dst as v8, row_number() over (partition by src order by dst DESC) as rn from Graph as g4;
# 2. minView
create or replace view minView7415033458167603992 as select v6, v8 as mfR6629014393932954821 from orderView1445365624903736685 where rn = 1;
# 3. joinView
create or replace view joinView6107075091243258568 as select src as v4, dst as v6, mfR6629014393932954821 from Graph AS g3, minView7415033458167603992 where g3.dst=minView7415033458167603992.v6;

# Reduce4
# 1. orderView
create or replace view orderView5434612803802186757 as select src as v1, dst as v2, row_number() over (partition by dst order by src) as rn from Graph as g1;
# 2. minView
create or replace view minView3940664053150645861 as select v2, v1 as mfL5437846918391390653 from orderView5434612803802186757 where rn = 1;
# 3. joinView
create or replace view joinView8697023439274004670 as select src as v2, dst as v4, mfL5437846918391390653 from Graph AS g2, minView3940664053150645861 where g2.src=minView3940664053150645861.v2;

# Reduce5
# 1. orderView
create or replace view orderView285925099364360281 as select v2, v4, mfL5437846918391390653, row_number() over (partition by v4 order by mfL5437846918391390653) as rn from joinView8697023439274004670;
# 2. minView
create or replace view minView5615081786417825901 as select v4, mfL5437846918391390653 as mfL7649384748814084004 from orderView285925099364360281 where rn = 1;
# 3. joinView
create or replace view joinView8370062700937409263 as select v4, v6, mfR6629014393932954821, mfL7649384748814084004 from joinView6107075091243258568 join minView5615081786417825901 using(v4) where mfL7649384748814084004<mfR6629014393932954821;

## Enumerate Phase: 

# Enumerate3
# 1. createSample
create or replace view sample3589065069766361166 as select * from orderView285925099364360281 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn1215594820383181825 as select v4, max(rn) as mrn from joinView8370062700937409263 join sample3589065069766361166 using(v4) where mfL5437846918391390653<mfR6629014393932954821 group by v4;
# 3. selectTarget
create or replace view target1702192809609303449 as select v2, v4, mfL5437846918391390653 from orderView285925099364360281 join maxRn1215594820383181825 using(v4) where rn < mrn + 5;
# 4. stageEnd
create or replace view end2021466088557906740 as select v6, v4, v2, mfL5437846918391390653, mfR6629014393932954821 from joinView8370062700937409263 join target1702192809609303449 using(v4) where mfL5437846918391390653<mfR6629014393932954821;

# Enumerate4
# 1. createSample
create or replace view sample6959397620483672746 as select * from orderView5434612803802186757 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn4882260200347247158 as select v2, max(rn) as mrn from end2021466088557906740 join sample6959397620483672746 using(v2) where v1<mfR6629014393932954821 group by v2;
# 3. selectTarget
create or replace view target4622751272320183077 as select v1, v2 from orderView5434612803802186757 join maxRn4882260200347247158 using(v2) where rn < mrn + 5;
# 4. stageEnd
create or replace view end8844321847029463333 as select v6, v1, v4, v2, mfR6629014393932954821 from end2021466088557906740 join target4622751272320183077 using(v2) where v1<mfR6629014393932954821;

# Enumerate5
# 1. createSample
create or replace view sample6538350235156055521 as select * from orderView1445365624903736685 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn8267736034561655717 as select v6, max(rn) as mrn from end8844321847029463333 join sample6538350235156055521 using(v6) where v1<v8 group by v6;
# 3. selectTarget
create or replace view target5608784141951469268 as select v6, v8 from orderView1445365624903736685 join maxRn8267736034561655717 using(v6) where rn < mrn + 5;
# 4. stageEnd
create or replace view end8754236124292424996 as select v6, v1, v4, v2, v8 from end8844321847029463333 join target5608784141951469268 using(v6) where v1<v8;
# Final result: 
select sum(v1+v2+v4+v6+v8) from end8754236124292424996;

# drop view orderView1445365624903736685, minView7415033458167603992, joinView6107075091243258568, orderView5434612803802186757, minView3940664053150645861, joinView8697023439274004670, orderView285925099364360281, minView5615081786417825901, joinView8370062700937409263, sample3589065069766361166, maxRn1215594820383181825, target1702192809609303449, end2021466088557906740, sample6959397620483672746, maxRn4882260200347247158, target4622751272320183077, end8844321847029463333, sample6538350235156055521, maxRn8267736034561655717, target5608784141951469268, end8754236124292424996;
