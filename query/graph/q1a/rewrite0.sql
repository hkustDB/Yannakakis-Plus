create or replace view bag164 as select g1.dst as v2, g2.dst as v4, g1.src as v6 from Graph as g1, Graph as g2, Graph as g3 where g1.dst=g2.src and g2.dst=g3.src and g3.dst=g1.src;
create or replace view minView242038739598304311 as select v2, ((v6 + v2) + v4) as mfL5149293421847384589 from bag164;
create or replace view joinView7337953160279779502 as select src as v2, dst as v12, mfL5149293421847384589 from Graph AS g7, minView242038739598304311 where g7.src=minView242038739598304311.v2;
create or replace view bag162 as select g5.dst as v10, g4.src as v12, g4.dst as v8 from Graph as g4, Graph as g5, Graph as g6 where g4.dst=g5.src and g5.dst=g6.src and g6.dst=g4.src;
create or replace view minView2360617349282300890 as select v12, ((v12 + v8) + v10) as mfR2162038404136278361 from bag162;
create or replace view joinView4494497198944197876 as select distinct v2, v12 from joinView7337953160279779502 join minView2360617349282300890 using(v12) where mfL5149293421847384589<mfR2162038404136278361;
select distinct v2, v12 from joinView4494497198944197876;
