
##Reduce Phase: 

# Reduce0
# 0. Prepare
create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
# 1. orderView
create or replace view orderView9126709806149448127 as select v4, v6, v10, row_number() over (partition by v4 order by v10) as rn from g3;
# 2. minView
create or replace view minView8554542741414843954 as select v4, v10 as mfL8898002321102444451 from orderView9126709806149448127 where rn = 1;
# 3. joinView
create or replace view joinView9178982230331329440 as select src as v2, dst as v4, mfL8898002321102444451 from Graph AS g2, minView8554542741414843954 where g2.dst=minView8554542741414843954.v4;

# Reduce1
# 0. Prepare
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
# 1. orderView
create or replace view orderView8332400828902188146 as select v2, v4, mfL8898002321102444451, row_number() over (partition by v2 order by mfL8898002321102444451) as rn from joinView9178982230331329440;
# 2. minView
create or replace view minView2970579914307551532 as select v2, mfL8898002321102444451 as mfL7871143081592383988 from orderView8332400828902188146 where rn = 1;
# 3. joinView
create or replace view joinView589249319639967948 as select v7, v2, v8, mfL7871143081592383988 from g1 join minView2970579914307551532 using(v2) where mfL7871143081592383988<=v8;

## Enumerate Phase: 

# Enumerate0
# 1. createSample
create or replace view sample5704998583214200298 as select * from orderView8332400828902188146 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn1572418789775945640 as select v2, max(rn) as mrn from joinView589249319639967948 join sample5704998583214200298 using(v2) where mfL8898002321102444451<=v8 group by v2;
# 3. selectTarget
create or replace view target1475861699698981576 as select v2, v4, mfL8898002321102444451 from orderView8332400828902188146 join maxRn1572418789775945640 using(v2) where rn < mrn + 5;
# 4. stageEnd
create or replace view end5122659898102799212 as select v4, v8, v7, v2, mfL8898002321102444451 from joinView589249319639967948 join target1475861699698981576 using(v2) where mfL8898002321102444451<=v8;

# Enumerate1
# 1. createSample
create or replace view sample2628963234767159982 as select * from orderView9126709806149448127 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn5083203190260155257 as select v4, max(rn) as mrn from end5122659898102799212 join sample2628963234767159982 using(v4) where v10<=v8 group by v4;
# 3. selectTarget
create or replace view target5065544517114608306 as select v4, v6, v10 from orderView9126709806149448127 join maxRn5083203190260155257 using(v4) where rn < mrn + 5;
# 4. stageEnd
create or replace view end4286112558090484227 as select v4, v7, v8, v10, v6, v2 from end5122659898102799212 join target5065544517114608306 using(v4) where v10<=v8;
# Final result: 
select sum(v7+v2+v4+v6+v8+v10) from end4286112558090484227;

# drop view g3, orderView9126709806149448127, minView8554542741414843954, joinView9178982230331329440, g1, orderView8332400828902188146, minView2970579914307551532, joinView589249319639967948, sample5704998583214200298, maxRn1572418789775945640, target1475861699698981576, end5122659898102799212, sample2628963234767159982, maxRn5083203190260155257, target5065544517114608306, end4286112558090484227;
