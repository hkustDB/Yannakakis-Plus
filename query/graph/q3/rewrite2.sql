
##Reduce Phase: 

# Reduce4
# 0. Prepare
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
create or replace view g2 as select Graph.src as v2, Graph.dst as v4, v12 from Graph, (SELECT src, COUNT(*) AS v12 FROM Graph GROUP BY src) AS c3 where Graph.src = c3.src;
# 1. orderView
create or replace view orderView6251313897002272118 as select v7, v2, v8, row_number() over (partition by v2 order by v8) as rn from g1;
# 2. minView
create or replace view minView2876929297110018255 as select v2, v8 as mfL2912702155479960729 from orderView6251313897002272118 where rn = 1;
# 3. joinView
create or replace view joinView2608126124154298942 as select v2, v4, v12, mfL2912702155479960729 from g2 join minView2876929297110018255 using(v2);

# Reduce5
# 0. Prepare
create or replace view g3 as select Graph.src as v4, Graph.dst as v9, v10, v14 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2, (SELECT dst, COUNT(*) AS v14 FROM Graph GROUP BY dst) AS c4 where Graph.dst = c2.src and Graph.dst = c4.dst;
# 1. orderView
create or replace view orderView6179937125453396682 as select v2, v4, v12, mfL2912702155479960729, row_number() over (partition by v4 order by mfL2912702155479960729) as rn from joinView2608126124154298942;
# 2. minView
create or replace view minView4802391374682022643 as select v4, mfL2912702155479960729 as mfL8863913524769768755 from orderView6179937125453396682 where rn = 1;
# 3. joinView
create or replace view joinView2393888873352172194 as select v4, v9, v10, v14, mfL8863913524769768755 from g3 join minView4802391374682022643 using(v4) where mfL8863913524769768755<v10;

## Enumerate Phase: 

# Enumerate4
# 1. createSample
create or replace view sample4418487578947339191 as select * from orderView6179937125453396682 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn8882625690371790009 as select v4, max(rn) as mrn from joinView2393888873352172194 join sample4418487578947339191 using(v4) where mfL2912702155479960729<v10 group by v4;
# 3. selectTarget
create or replace view target7720472702700278112 as select v2, v4, v12, mfL2912702155479960729 from orderView6179937125453396682 join maxRn8882625690371790009 using(v4) where rn < mrn + 5;
# 4. stageEnd
create or replace view end1453927450985734031 as select v14, v12, v2, v9, v10, v4, mfL2912702155479960729 from joinView2393888873352172194 join target7720472702700278112 using(v4) where mfL2912702155479960729<v10 and v12<v14;

# Enumerate5
# 1. createSample
create or replace view sample6415779519902579594 as select * from orderView6251313897002272118 where rn % 5 = 1;
# 2. selectMax
create or replace view maxRn3577658743602438346 as select v2, max(rn) as mrn from end1453927450985734031 join sample6415779519902579594 using(v2) where v8<v10 group by v2;
# 3. selectTarget
create or replace view target531486230938200006 as select v7, v2, v8 from orderView6251313897002272118 join maxRn3577658743602438346 using(v2) where rn < mrn + 5;
# 4. stageEnd
create or replace view end2162773598508740671 as select v8, v7, v14, v12, v2, v9, v10, v4 from end1453927450985734031 join target531486230938200006 using(v2) where v8<v10;
# Final result: 
select sum(v7+v2+v4+v9+v8+v10+v12+v14) from end2162773598508740671;

# drop view g1, g2, orderView6251313897002272118, minView2876929297110018255, joinView2608126124154298942, g3, orderView6179937125453396682, minView4802391374682022643, joinView2393888873352172194, sample4418487578947339191, maxRn8882625690371790009, target7720472702700278112, end1453927450985734031, sample6415779519902579594, maxRn3577658743602438346, target531486230938200006, end2162773598508740671;
