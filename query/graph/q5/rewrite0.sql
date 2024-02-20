
##Reduce Phase: 

# Reduce0
# 0. Prepare
create or replace view g1 as select Graph.src as v1, Graph.dst as v2, v12 from Graph, (SELECT src, COUNT(*) AS v12 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
# 2. minView
create or replace view minView2179226041791989278 as select v2, min(v12) as mfL8716594865715907276 from g1 group by v2;
# 3. joinView
create or replace view joinView6868367667226386307 as select src as v2, dst as v4, mfL8716594865715907276 from Graph AS g2, minView2179226041791989278 where g2.src=minView2179226041791989278.v2;

# Reduce1
# 0. Prepare
create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v14 from Graph, (SELECT src, COUNT(*) AS v14 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
# 2. minView
create or replace view minView1790413081448163857 as select v4, max(v14) as mfR687513156366278427 from g3 group by v4;
# 3. joinView
create or replace view joinView8776891218700831393 as select v2, v4, mfL8716594865715907276, mfR687513156366278427 from joinView6868367667226386307 join minView1790413081448163857 using(v4) where mfL8716594865715907276<mfR687513156366278427;

# Reduce2
# 0. Prepare
create or replace view g5 as select Graph.src as v4, Graph.dst as v10, v18 from Graph, (SELECT dst, COUNT(*) AS v18 FROM Graph GROUP BY dst) AS c4 where Graph.dst = c4.dst;
# 2. minView
create or replace view minView7597581095949862970 as select v4, max(v18) as mfR4373715631006271463 from g5 group by v4;
# 3. joinView
create or replace view joinView5168268577383369977 as select v2, v4, mfL8716594865715907276, mfR687513156366278427, mfR4373715631006271463 from joinView8776891218700831393 join minView7597581095949862970 using(v4);

# Reduce3
# 0. Prepare
create or replace view g4 as select Graph.src as v7, Graph.dst as v2, v16 from Graph, (SELECT dst, COUNT(*) AS v16 FROM Graph GROUP BY dst) AS c3 where Graph.src = c3.dst;
# 2. minView
create or replace view minView4297420701131104776 as select v2, min(v16) as mfL5822617764284661662 from g4 group by v2;
# 3. joinView
create or replace view joinView3983927724252889106 as select v2, v4 from joinView5168268577383369977 join minView4297420701131104776 using(v2) where mfL5822617764284661662<mfR4373715631006271463;
# Final result: 
select sum(distinct v2+v4) from joinView3983927724252889106;

# drop view g1, minView2179226041791989278, joinView6868367667226386307, g3, minView1790413081448163857, joinView8776891218700831393, g5, minView7597581095949862970, joinView5168268577383369977, g4, minView4297420701131104776, joinView3983927724252889106;
