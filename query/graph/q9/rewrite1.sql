create or replace view semiJoinView6260526784937944882 as select g1.src as v1, g3.dst as v6 from Graph as g1, Graph as g2, Graph as g3 where g1.dst=g2.src and g2.dst=g3.src;
create or replace view orderView91451302358457020 as select src as v6, dst as v8, row_number() over (partition by src order by dst DESC) as rn from Graph as g4;
create or replace view minView2483098148909844243 as select v6, v8 as mfR4722933714245984771 from orderView91451302358457020 where rn = 1;
create or replace view joinView7730870078807950200 as select v1, v6, mfR4722933714245984771 from semiJoinView6260526784937944882 join minView2483098148909844243 using(v6) where v1<mfR4722933714245984771;
create or replace view sample2405254945442097072 as select * from orderView91451302358457020 where rn % 5 = 1;
create or replace view maxRn3376902372974386053 as select v6, max(rn) as mrn from joinView7730870078807950200 join sample2405254945442097072 using(v6) where v1<v8 group by v6;
create or replace view target6066098324991493845 as select v6, v8 from orderView91451302358457020 join maxRn3376902372974386053 using(v6) where rn < mrn + 5;
create or replace view end3285087383674126193 as select v1, v6, v8 from joinView7730870078807950200 join target6066098324991493845 using(v6) where v1<v8;
select distinct v1, v6, v8 from end3285087383674126193;
