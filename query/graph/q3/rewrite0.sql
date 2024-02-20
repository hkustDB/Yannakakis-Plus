
##Reduce Phase: 

# Reduce0
# 0. Prepare
create or replace view g3 as select Graph.src as v4, Graph.dst as v9, v10, v14 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2, (SELECT dst, COUNT(*) AS v14 FROM Graph GROUP BY dst) AS c4 where Graph.dst = c2.src and Graph.dst = c4.dst;
create or replace view g2 as select Graph.src as v2, Graph.dst as v4, v12 from Graph, (SELECT src, COUNT(*) AS v12 FROM Graph GROUP BY src) AS c3 where Graph.src = c3.src;
# 1. orderView
create or replace view orderView3512813419817994087 as select v4, v9, v10, v14, row_number() over (partition by v4 order by v10 DESC) as rn from g3;
# 2. minView
create or replace view minView8187226092933486306 as select v4, v10 as mfR6087559097080698382 from orderView3512813419817994087 where rn = 1;
# 3. joinView
create or replace view joinView6588140849283279933 as select v2, v4, v12, mfR6087559097080698382 from g2 join minView8187226092933486306 using(v4);

# Reduce1
# 0. Prepare
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
# 1. orderView
create or replace view orderView7171070654270965521 as select v7, v2, v8, row_number() over (partition by v2 order by v8) as rn from g1;
# 2. minView
create or replace view minView2649662157586409853 as select v2, v8 as mfL5439523795323241249 from orderView7171070654270965521 where rn = 1;
# 3. joinView
create or replace view joinView4551591047071028340 as select v2, v4, v12, mfR6087559097080698382, mfL5439523795323241249 from joinView6588140849283279933 join minView2649662157586409853 using(v2) where mfL5439523795323241249<mfR6087559097080698382;

## Enumerate Phase: 

# Enumerate0
# 1. createSample
create or replace view sample5776563210201188502 as select * from orderView7171070654270965521 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn1140967515632260989 as select v2, max(rn) as mrn from joinView4551591047071028340 join sample5776563210201188502 using(v2) where v8<mfR6087559097080698382 group by v2;
# 3. selectTarget
create or replace view target5851841950290039669 as select v7, v2, v8 from orderView7171070654270965521 join maxRn1140967515632260989 using(v2) where rn < mrn + 5;
# 4. stageEnd
create or replace view end9160193268050980581 as select v8, v7, v4, v2, v12, mfR6087559097080698382 from joinView4551591047071028340 join target5851841950290039669 using(v2) where v8<mfR6087559097080698382;

# Enumerate1
# 1. createSample
create or replace view sample5303768085278849767 as select * from orderView3512813419817994087 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn1042096447936577435 as select v4, max(rn) as mrn from end9160193268050980581 join sample5303768085278849767 using(v4) where v8<v10 group by v4;
# 3. selectTarget
create or replace view target2267824205476062445 as select v4, v9, v10, v14 from orderView3512813419817994087 join maxRn1042096447936577435 using(v4) where rn < mrn + 5;
# 4. stageEnd
create or replace view end2552047945327561620 as select v8, v7, v14, v12, v9, v10, v4, v2 from end9160193268050980581 join target2267824205476062445 using(v4) where v8<v10 and v12<v14;
# Final result: 
select sum(v7+v2+v4+v9+v8+v10+v12+v14) from end2552047945327561620;

# drop view g3, g2, orderView3512813419817994087, minView8187226092933486306, joinView6588140849283279933, g1, orderView7171070654270965521, minView2649662157586409853, joinView4551591047071028340, sample5776563210201188502, maxRn1140967515632260989, target5851841950290039669, end9160193268050980581, sample5303768085278849767, maxRn1042096447936577435, target2267824205476062445, end2552047945327561620;
