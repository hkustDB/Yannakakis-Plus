
##Reduce Phase: 

# Reduce2
# 0. Prepare
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
# 1. orderView
create or replace view orderView6036759014579400878 as select v7, v2, v8, row_number() over (partition by v2 order by v8) as rn from g1;
# 2. minView
create or replace view minView6848015012633468079 as select v2, v8 as mfL1016761298729594681 from orderView6036759014579400878 where rn = 1;
# 3. joinView
create or replace view joinView3121883756133482129 as select src as v2, dst as v4, mfL1016761298729594681 from Graph AS g2, minView6848015012633468079 where g2.src=minView6848015012633468079.v2;

# Reduce3
# 0. Prepare
create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
# 1. orderView
create or replace view orderView6798856446372501526 as select v2, v4, mfL1016761298729594681, row_number() over (partition by v4 order by mfL1016761298729594681) as rn from joinView3121883756133482129;
# 2. minView
create or replace view minView7453555212002650251 as select v4, mfL1016761298729594681 as mfL3046814655355335838 from orderView6798856446372501526 where rn = 1;
# 3. joinView
create or replace view joinView7100257619061073710 as select v4, v6, v10, mfL3046814655355335838 from g3 join minView7453555212002650251 using(v4) where mfL3046814655355335838<v6;

## Enumerate Phase: 

# Enumerate2
# 1. createSample
create or replace view sample4492293149788947086 as select * from orderView6798856446372501526 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn4167444040019738703 as select v4, max(rn) as mrn from joinView7100257619061073710 join sample4492293149788947086 using(v4) where mfL1016761298729594681<v6 group by v4;
# 3. selectTarget
create or replace view target8792455310677830084 as select v2, v4, mfL1016761298729594681 from orderView6798856446372501526 join maxRn4167444040019738703 using(v4) where rn < mrn + 5;
# 4. stageEnd
create or replace view end1201189231874988239 as select v10, v2, v4, v6, mfL1016761298729594681 from joinView7100257619061073710 join target8792455310677830084 using(v4) where mfL1016761298729594681<v6;

# Enumerate3
# 1. createSample
create or replace view sample8309452090840579862 as select * from orderView6036759014579400878 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn2016694556426836295 as select v2, max(rn) as mrn from end1201189231874988239 join sample8309452090840579862 using(v2) where v8<v6 group by v2;
# 3. selectTarget
create or replace view target6191678936370278669 as select v7, v2, v8 from orderView6036759014579400878 join maxRn2016694556426836295 using(v2) where rn < mrn + 5;
# 4. stageEnd
create or replace view end1174069978108938451 as select v7, v10, v2, v4, v8, v6 from end1201189231874988239 join target6191678936370278669 using(v2) where v8<v6;
# Final result: 
select sum(v7+v2+v4+v6+v8+v10) from end1174069978108938451;

# drop view g1, orderView6036759014579400878, minView6848015012633468079, joinView3121883756133482129, g3, orderView6798856446372501526, minView7453555212002650251, joinView7100257619061073710, sample4492293149788947086, maxRn4167444040019738703, target8792455310677830084, end1201189231874988239, sample8309452090840579862, maxRn2016694556426836295, target6191678936370278669, end1174069978108938451;
