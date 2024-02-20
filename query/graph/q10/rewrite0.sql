
##Reduce Phase: 

# Reduce0
# 1. orderView
create or replace view orderView4925501687388935571 as select src as v6, dst as v8, row_number() over (partition by src order by dst DESC) as rn from Graph as g4;
# 2. minView
create or replace view minView599779715509005510 as select v6, v8 as mfR5807814273975793609 from orderView4925501687388935571 where rn = 1;
# 3. joinView
create or replace view joinView6812415038506994293 as select src as v4, dst as v6, mfR5807814273975793609 from Graph AS g3, minView599779715509005510 where g3.dst=minView599779715509005510.v6;

# Reduce1
# 1. orderView
create or replace view orderView1776763829871194842 as select v4, v6, mfR5807814273975793609, row_number() over (partition by v4 order by mfR5807814273975793609 DESC) as rn from joinView6812415038506994293;
# 2. minView
create or replace view minView1907519527288999387 as select v4, mfR5807814273975793609 as mfR1184436327701097130 from orderView1776763829871194842 where rn = 1;
# 3. joinView
create or replace view joinView708020587187640756 as select src as v2, dst as v4, mfR1184436327701097130 from Graph AS g2, minView1907519527288999387 where g2.dst=minView1907519527288999387.v4;

# Reduce2
# 1. orderView
create or replace view orderView1111757444851055772 as select v2, v4, mfR1184436327701097130, row_number() over (partition by v2 order by mfR1184436327701097130 DESC) as rn from joinView708020587187640756;
# 2. minView
create or replace view minView3568453372725768799 as select v2, mfR1184436327701097130 as mfR8207416769642287507 from orderView1111757444851055772 where rn = 1;
# 3. joinView
create or replace view joinView4642155693219270170 as select src as v1, dst as v2, mfR8207416769642287507 from Graph AS g1, minView3568453372725768799 where g1.dst=minView3568453372725768799.v2 and src<mfR8207416769642287507;

## Enumerate Phase: 

# Enumerate0
# 1. createSample
create or replace view sample5264178464656139813 as select * from orderView1111757444851055772 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn4317283454968358371 as select v2, max(rn) as mrn from joinView4642155693219270170 join sample5264178464656139813 using(v2) where v1<mfR1184436327701097130 group by v2;
# 3. selectTarget
create or replace view target2317539757555306428 as select v2, v4, mfR1184436327701097130 from orderView1111757444851055772 join maxRn4317283454968358371 using(v2) where rn < mrn + 5;
# 4. stageEnd
create or replace view end3862218284551144572 as select v4, v1, v2, mfR1184436327701097130 from joinView4642155693219270170 join target2317539757555306428 using(v2) where v1<mfR1184436327701097130;

# Enumerate1
# 1. createSample
create or replace view sample2137058367192261871 as select * from orderView1776763829871194842 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn4104636795611659857 as select v4, max(rn) as mrn from end3862218284551144572 join sample2137058367192261871 using(v4) where v1<mfR5807814273975793609 group by v4;
# 3. selectTarget
create or replace view target4584218984899419119 as select v4, v6, mfR5807814273975793609 from orderView1776763829871194842 join maxRn4104636795611659857 using(v4) where rn < mrn + 5;
# 4. stageEnd
create or replace view end7949987254978340780 as select v6, v4, v1, v2, mfR5807814273975793609 from end3862218284551144572 join target4584218984899419119 using(v4) where v1<mfR5807814273975793609;

# Enumerate2
# 1. createSample
create or replace view sample3083729084688799943 as select * from orderView4925501687388935571 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn8559495982211455996 as select v6, max(rn) as mrn from end7949987254978340780 join sample3083729084688799943 using(v6) where v1<v8 group by v6;
# 3. selectTarget
create or replace view target7110855619960456921 as select v6, v8 from orderView4925501687388935571 join maxRn8559495982211455996 using(v6) where rn < mrn + 5;
# 4. stageEnd
create or replace view end7375224363936411418 as select v6, v4, v1, v2, v8 from end7949987254978340780 join target7110855619960456921 using(v6) where v1<v8;
# Final result: 
select sum(v1+v2+v4+v6+v8) from end7375224363936411418;

# drop view orderView4925501687388935571, minView599779715509005510, joinView6812415038506994293, orderView1776763829871194842, minView1907519527288999387, joinView708020587187640756, orderView1111757444851055772, minView3568453372725768799, joinView4642155693219270170, sample5264178464656139813, maxRn4317283454968358371, target2317539757555306428, end3862218284551144572, sample2137058367192261871, maxRn4104636795611659857, target4584218984899419119, end7949987254978340780, sample3083729084688799943, maxRn8559495982211455996, target7110855619960456921, end7375224363936411418;
