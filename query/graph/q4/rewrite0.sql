
##Reduce Phase: 

# Reduce0
# 0. Prepare
create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
create or replace view g3Aux75 as select v4, v6, v10 from g3;

# Reduce1
# 0. Prepare
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
# 2. minView
create or replace view minView9180085900905049042 as select v2, min(v8) as mfL2406671125670914663 from g1 group by v2;
# 3. joinView
create or replace view joinView4693479197722542565 as select src as v2, dst as v4, mfL2406671125670914663 from Graph AS g2, minView9180085900905049042 where g2.src=minView9180085900905049042.v2;

# Reduce2
# 2. minView
create or replace view minView4845673805951486802 as select v4, min(mfL2406671125670914663) as mfL8252491637394999180 from joinView4693479197722542565 group by v4;
# 3. joinView
create or replace view joinView8285027299382598331 as select v4, v6 from g3Aux75 join minView4845673805951486802 using(v4) where mfL8252491637394999180<v10;
# Final result: 
select sum(distinct v4+v6) from joinView8285027299382598331;

# drop view g3, g3Aux75, g1, minView9180085900905049042, joinView4693479197722542565, minView4845673805951486802, joinView8285027299382598331;
