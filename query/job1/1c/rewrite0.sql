create or replace view aggView9124021307233122647 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1879142448106180659 as select movie_id as v15, note as v9 from movie_companies as mc, aggView9124021307233122647 where mc.company_type_id=aggView9124021307233122647.v1 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView3200695578383360408 as select v15, MIN(v9) as v27 from aggJoin1879142448106180659 group by v15;
create or replace view aggJoin6165701329990953901 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView3200695578383360408 where t.id=aggView3200695578383360408.v15 and production_year>2010;
create or replace view aggView7350387247896334168 as select v15, MIN(v27) as v27, MIN(v16) as v28, MIN(v19) as v29 from aggJoin6165701329990953901 group by v15;
create or replace view aggJoin1319596023546446766 as select info_type_id as v3, v27, v28, v29 from movie_info_idx as mi_idx, aggView7350387247896334168 where mi_idx.movie_id=aggView7350387247896334168.v15;
create or replace view aggView8510471958638846454 as select v3, MIN(v27) as v27, MIN(v28) as v28, MIN(v29) as v29 from aggJoin1319596023546446766 group by v3;
create or replace view aggJoin3940223291803430862 as select v27, v28, v29 from info_type as it, aggView8510471958638846454 where it.id=aggView8510471958638846454.v3 and info= 'top 250 rank';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin3940223291803430862;
