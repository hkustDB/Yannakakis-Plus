
##Reduce Phase: 

# Reduce2
# 0. Prepare
create or replace view g3 as select Graph.src as v4, Graph.dst as v9, v10, v14 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2, (SELECT dst, COUNT(*) AS v14 FROM Graph GROUP BY dst) AS c4 where Graph.dst = c2.src and Graph.dst = c4.dst;
create or replace view g2 as select Graph.src as v2, Graph.dst as v4, v12 from Graph, (SELECT src, COUNT(*) AS v12 FROM Graph GROUP BY src) AS c3 where Graph.src = c3.src;
# 1. orderView
create or replace view orderView319293734448017523 as select v4, v9, v10, v14, row_number() over (partition by v4 order by v10 DESC) as rn from g3;
# 2. minView
create or replace view minView4307583332121619986 as select v4, v10 as mfR4073265163200366296 from orderView319293734448017523 where rn = 1;
# 3. joinView
create or replace view joinView3712150908120849167 as select v2, v4, v12, mfR4073265163200366296 from g2 join minView4307583332121619986 using(v4);

# Reduce3
# 0. Prepare
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
# 1. orderView
create or replace view orderView3990875474756149179 as select v2, v4, v12, mfR4073265163200366296, row_number() over (partition by v2 order by mfR4073265163200366296 DESC) as rn from joinView3712150908120849167;
# 2. minView
create or replace view minView3216283338598947316 as select v2, mfR4073265163200366296 as mfR1856225802876043742 from orderView3990875474756149179 where rn = 1;
# 3. joinView
create or replace view joinView7831404963533692553 as select v7, v2, v8, mfR1856225802876043742 from g1 join minView3216283338598947316 using(v2) where v8<mfR1856225802876043742;

## Enumerate Phase: 

# Enumerate2
# 1. createSample
create or replace view sample3470337933249663967 as select * from orderView3990875474756149179 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn5830699814660833342 as select v2, max(rn) as mrn from joinView7831404963533692553 join sample3470337933249663967 using(v2) where v8<mfR4073265163200366296 group by v2;
# 3. selectTarget
create or replace view target3980122409073789855 as select v2, v4, v12, mfR4073265163200366296 from orderView3990875474756149179 join maxRn5830699814660833342 using(v2) where rn < mrn + 5;
# 4. stageEnd
create or replace view end343152648004581468 as select v8, v7, v12, v4, v2, mfR4073265163200366296 from joinView7831404963533692553 join target3980122409073789855 using(v2) where v8<mfR4073265163200366296;

# Enumerate3
# 1. createSample
create or replace view sample6327486858470759012 as select * from orderView319293734448017523 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn7482737495712260571 as select v4, max(rn) as mrn from end343152648004581468 join sample6327486858470759012 using(v4) where v8<v10 group by v4;
# 3. selectTarget
create or replace view target595760128355302444 as select v4, v9, v10, v14 from orderView319293734448017523 join maxRn7482737495712260571 using(v4) where rn < mrn + 5;
# 4. stageEnd
create or replace view end5143489978001475170 as select v8, v7, v10, v14, v12, v9, v4, v2 from end343152648004581468 join target595760128355302444 using(v4) where v8<v10 and v12<v14;
# Final result: 
select sum(v7+v2+v4+v9+v8+v10+v12+v14) from end5143489978001475170;

# drop view g3, g2, orderView319293734448017523, minView4307583332121619986, joinView3712150908120849167, g1, orderView3990875474756149179, minView3216283338598947316, joinView7831404963533692553, sample3470337933249663967, maxRn5830699814660833342, target3980122409073789855, end343152648004581468, sample6327486858470759012, maxRn7482737495712260571, target595760128355302444, end5143489978001475170;
