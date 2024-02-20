
##Reduce Phase: 

# Reduce6
# 2. minView
create or replace view minView6612400269613170055 as select dst as v2, min(src) as mfL954354836503852646 from Graph as g1 group by v2;
# 3. joinView
create or replace view joinView1455944271153649574 as select src as v2, dst as v4, mfL954354836503852646 from Graph AS g2, minView6612400269613170055 where g2.src=minView6612400269613170055.v2;

# Reduce7
# 2. minView
create or replace view minView3413826927517185406 as select src as v12, max(dst) as mfR6966462426573542605 from Graph as g7 group by v12;
# 3. joinView
create or replace view joinView2220979447449085004 as select src as v10, dst as v12, mfR6966462426573542605 from Graph AS g6, minView3413826927517185406 where g6.dst=minView3413826927517185406.v12;

# Reduce8
# 2. minView
create or replace view minView5968453428497834922 as select v4, min(mfL954354836503852646) as mfL641783255248329571 from joinView1455944271153649574 group by v4;
# 3. joinView
create or replace view joinView1211140826137731172 as select src as v4, dst as v6, mfL641783255248329571 from Graph AS g3, minView5968453428497834922 where g3.src=minView5968453428497834922.v4;

# Reduce9
# 2. minView
create or replace view minView3806475530991049287 as select v6, min(mfL641783255248329571) as mfL7962688982225200789 from joinView1211140826137731172 group by v6;
# 3. joinView
create or replace view joinView1224275441629478546 as select src as v6, dst as v8, mfL7962688982225200789 from Graph AS g4, minView3806475530991049287 where g4.src=minView3806475530991049287.v6;

# Reduce10
# 2. minView
create or replace view minView1651699447663046560 as select v8, min(mfL7962688982225200789) as mfL1251517337031855481 from joinView1224275441629478546 group by v8;
# 3. joinView
create or replace view joinView1621568983827306495 as select src as v8, dst as v10, mfL1251517337031855481 from Graph AS g5, minView1651699447663046560 where g5.src=minView1651699447663046560.v8;

# Reduce11
# 1. orderView
create or replace view orderView2243230054672560226 as select v8, v10, mfL1251517337031855481, row_number() over (partition by v10 order by mfL1251517337031855481) as rn from joinView1621568983827306495;
# 2. minView
create or replace view minView4702079904579382205 as select v10, mfL1251517337031855481 as mfL7813846747569739906 from orderView2243230054672560226 where rn = 1;
# 3. joinView
create or replace view joinView6923170261019892699 as select v10, v12, mfR6966462426573542605, mfL7813846747569739906 from joinView2220979447449085004 join minView4702079904579382205 using(v10) where mfL7813846747569739906<mfR6966462426573542605;

## Enumerate Phase: 

# Enumerate1
# 1. createSample
create or replace view sample1956688587270391995 as select * from orderView2243230054672560226 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn5809634583731024246 as select v10, max(rn) as mrn from joinView6923170261019892699 join sample1956688587270391995 using(v10) where mfL1251517337031855481<mfR6966462426573542605 group by v10;
# 3. selectTarget
create or replace view target4303171451106116123 as select v8, v10, mfL1251517337031855481 from orderView2243230054672560226 join maxRn5809634583731024246 using(v10) where rn < mrn + 5;
# 4. stageEnd
create or replace view end8178707341733693865 as select v8, v10, v12 from joinView6923170261019892699 join target4303171451106116123 using(v10) where mfL1251517337031855481<mfR6966462426573542605;
# Final result: 
select sum(distinct v8+v10+v12) from end8178707341733693865;

# drop view minView6612400269613170055, joinView1455944271153649574, minView3413826927517185406, joinView2220979447449085004, minView5968453428497834922, joinView1211140826137731172, minView3806475530991049287, joinView1224275441629478546, minView1651699447663046560, joinView1621568983827306495, orderView2243230054672560226, minView4702079904579382205, joinView6923170261019892699, sample1956688587270391995, maxRn5809634583731024246, target4303171451106116123, end8178707341733693865;
