
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
create or replace view g2 as select Graph.src as v2, Graph.dst as v4, v12 from Graph, (SELECT src, COUNT(*) AS v12 FROM Graph GROUP BY src) AS c3 where Graph.src = c3.src;
create or replace view orderView6441979147187950152 as select v7, v2, v8, row_number() over (partition by v2 order by v8) as rn from g1;
create or replace view minView7440341975936162107 as select v2, v8 as mfL1991950168803344754 from orderView6441979147187950152 where rn = 1;
create or replace view joinView8740956174359676606 as select v2, v4, v12, mfL1991950168803344754 from g2 join minView7440341975936162107 using(v2);
create or replace view g3 as select Graph.src as v4, Graph.dst as v9, v10, v14 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2, (SELECT dst, COUNT(*) AS v14 FROM Graph GROUP BY dst) AS c4 where Graph.dst = c2.src and Graph.dst = c4.dst;
create or replace view orderView8395628036832074863 as select v4, v9, v10, v14, row_number() over (partition by v4 order by v10 DESC) as rn from g3;
create or replace view minView6311067447397549781 as select v4, v10 as mfR5893277672513176122 from orderView8395628036832074863 where rn = 1;
create or replace view joinView3265404636006029947 as select v2, v4, v12, mfL1991950168803344754, mfR5893277672513176122 from joinView8740956174359676606 join minView6311067447397549781 using(v4) where mfL1991950168803344754<mfR5893277672513176122;
create or replace view sample2213805785759978902 as select * from orderView8395628036832074863 where rn % 5 = 1;
create or replace view maxRn1701027862870469133 as select v4, max(rn) as mrn from joinView3265404636006029947 join sample2213805785759978902 using(v4) where mfL1991950168803344754<v10 group by v4;
create or replace view target2308642385995270873 as select v4, v9, v10, v14 from orderView8395628036832074863 join maxRn1701027862870469133 using(v4) where rn < mrn + 5;
create or replace view end3352879301656333614 as select v9, v10, v2, v12, v14, v4, mfL1991950168803344754 from joinView3265404636006029947 join target2308642385995270873 using(v4) where mfL1991950168803344754<v10 and v12<v14;
create or replace view sample2192164103222857216 as select * from orderView6441979147187950152 where rn % 5 = 1;
create or replace view maxRn510519536629446677 as select v2, max(rn) as mrn from end3352879301656333614 join sample2192164103222857216 using(v2) where v8<v10 group by v2;
create or replace view target788720868283041373 as select v7, v2, v8 from orderView6441979147187950152 join maxRn510519536629446677 using(v2) where rn < mrn + 5;
create or replace view end6018174537634284604 as select v8, v9, v10, v2, v14, v12, v4, v7 from end3352879301656333614 join target788720868283041373 using(v2) where v8<v10;
select sum(v2+v4+v7+v8+v9+v10+v12+v14) from end6018174537634284604;
