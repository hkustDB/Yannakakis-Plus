
##Reduce Phase: 

# Reduce0
# 0. Prepare
create or replace view bag321 as select g1.dst as v2, g2.dst as v4, g1.src as v6 from Graph as g1, Graph as g2, Graph as g3 where g1.dst=g2.src and g2.dst=g3.src and g3.dst=g1.src;
# 1. orderView
create or replace view orderView7444325064556641769 as select v2, v4, v6, ((v6 + v2) + v4) as oriLeft, row_number() over (partition by v2 order by ((v6 + v2) + v4)) as rn from bag321;
# 2. minView
create or replace view minView5137687763375083050 as select v2, oriLeft as mfL8657067728923511728 from orderView7444325064556641769 where rn = 1;
# 3. joinView
create or replace view joinView4984864253798107180 as select src as v2, dst as v12, mfL8657067728923511728 from Graph AS g7, minView5137687763375083050 where g7.src=minView5137687763375083050.v2;

# Reduce1
# 0. Prepare
create or replace view bag322 as select g5.dst as v10, g4.src as v12, g4.dst as v8 from Graph as g4, Graph as g5, Graph as g6 where g4.dst=g5.src and g5.dst=g6.src and g6.dst=g4.src;
# 1. orderView
create or replace view orderView2602166072875205564 as select v10, v12, v8, ((v12 + v8) + v10) as oriRight, row_number() over (partition by v12 order by ((v12 + v8) + v10) DESC) as rn from bag322;
# 2. minView
create or replace view minView2962414663850520167 as select v12, oriRight as mfR8240396411234655678 from orderView2602166072875205564 where rn = 1;
# 3. joinView
create or replace view joinView6535810166211436454 as select v2, v12, mfL8657067728923511728, mfR8240396411234655678 from joinView4984864253798107180 join minView2962414663850520167 using(v12) where mfL8657067728923511728<=mfR8240396411234655678;

## Enumerate Phase: 

# Enumerate0
# 1. createSample
create or replace view sample940374651149179790 as select * from orderView2602166072875205564 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn72803853373934774 as select v12, max(rn) as mrn from joinView6535810166211436454 join sample940374651149179790 using(v12) where mfL8657067728923511728<=oriRight group by v12;
# 3. selectTarget
create or replace view target8413626695917616097 as select v10, v12, v8, oriRight from orderView2602166072875205564 join maxRn72803853373934774 using(v12) where rn < mrn + 5;
# 4. stageEnd
create or replace view end8494775162880796612 as select v12, v2, v8, v10, mfL8657067728923511728 from joinView6535810166211436454 join target8413626695917616097 using(v12) where mfL8657067728923511728<=oriRight;

# Enumerate1
# 1. createSample
create or replace view sample2622727019269836821 as select * from orderView7444325064556641769 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn4225415843585083453 as select v2, max(rn) as mrn from end8494775162880796612 join sample2622727019269836821 using(v2) where oriLeft<=((v12 + v8) + v10) group by v2;
# 3. selectTarget
create or replace view target2303936756243241626 as select v2, v4, v6, oriLeft from orderView7444325064556641769 join maxRn4225415843585083453 using(v2) where rn < mrn + 5;
# 4. stageEnd
create or replace view end306615846123568209 as select v6, v12, v2, v8, v4, v10 from end8494775162880796612 join target2303936756243241626 using(v2) where oriLeft<=((v12 + v8) + v10);
# Final result: 
select sum(v6+v2+v2+v4+v4+v6+v12+v8+v8+v10+v10+v12+v2+v12) from end306615846123568209;

# drop view bag321, orderView7444325064556641769, minView5137687763375083050, joinView4984864253798107180, bag322, orderView2602166072875205564, minView2962414663850520167, joinView6535810166211436454, sample940374651149179790, maxRn72803853373934774, target8413626695917616097, end8494775162880796612, sample2622727019269836821, maxRn4225415843585083453, target2303936756243241626, end306615846123568209;
