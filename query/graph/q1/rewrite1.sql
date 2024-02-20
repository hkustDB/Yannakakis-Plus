
##Reduce Phase: 

# Reduce2
# 0. Prepare
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
# 1. orderView
create or replace view orderView6016326764271386120 as select v7, v2, v8, row_number() over (partition by v2 order by v8 DESC) as rn from g1;
# 2. minView
create or replace view minView6370649248002946509 as select v2, v8 as mfR4750533744879512024 from orderView6016326764271386120 where rn = 1;
# 3. joinView
create or replace view joinView5024715461625695606 as select src as v2, dst as v4, mfR4750533744879512024 from Graph AS g2, minView6370649248002946509 where g2.src=minView6370649248002946509.v2;

# Reduce3
# 0. Prepare
create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
# 1. orderView
create or replace view orderView6694605302999320288 as select v4, v6, v10, row_number() over (partition by v4 order by v10) as rn from g3;
# 2. minView
create or replace view minView2505931812067414526 as select v4, v10 as mfL4354255845338068881 from orderView6694605302999320288 where rn = 1;
# 3. joinView
create or replace view joinView6600756319806680390 as select v2, v4, mfR4750533744879512024, mfL4354255845338068881 from joinView5024715461625695606 join minView2505931812067414526 using(v4) where mfL4354255845338068881<=mfR4750533744879512024;

## Enumerate Phase: 

# Enumerate2
# 1. createSample
create or replace view sample3759044724018882913 as select * from orderView6694605302999320288 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn1865161444766290698 as select v4, max(rn) as mrn from joinView6600756319806680390 join sample3759044724018882913 using(v4) where v10<=mfR4750533744879512024 group by v4;
# 3. selectTarget
create or replace view target8166322153664404683 as select v4, v6, v10 from orderView6694605302999320288 join maxRn1865161444766290698 using(v4) where rn < mrn + 5;
# 4. stageEnd
create or replace view end1390925548993716717 as select v4, v10, v6, v2, mfR4750533744879512024 from joinView6600756319806680390 join target8166322153664404683 using(v4) where v10<=mfR4750533744879512024;

# Enumerate3
# 1. createSample
create or replace view sample5800679101474750921 as select * from orderView6016326764271386120 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn5236853044010605352 as select v2, max(rn) as mrn from end1390925548993716717 join sample5800679101474750921 using(v2) where v10<=v8 group by v2;
# 3. selectTarget
create or replace view target7089296405507323276 as select v7, v2, v8 from orderView6016326764271386120 join maxRn5236853044010605352 using(v2) where rn < mrn + 5;
# 4. stageEnd
create or replace view end6862990619878078668 as select v4, v8, v7, v6, v2, v10 from end1390925548993716717 join target7089296405507323276 using(v2) where v10<=v8;
# Final result: 
select sum(v7+v2+v4+v6+v8+v10) from end6862990619878078668;

# drop view g1, orderView6016326764271386120, minView6370649248002946509, joinView5024715461625695606, g3, orderView6694605302999320288, minView2505931812067414526, joinView6600756319806680390, sample3759044724018882913, maxRn1865161444766290698, target8166322153664404683, end1390925548993716717, sample5800679101474750921, maxRn5236853044010605352, target7089296405507323276, end6862990619878078668;
