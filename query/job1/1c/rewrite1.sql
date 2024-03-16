create or replace view aggView3603106648480246599 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin405257355255135904 as select movie_id as v15 from movie_info_idx as mi_idx, aggView3603106648480246599 where mi_idx.info_type_id=aggView3603106648480246599.v3;
create or replace view aggView7904781013239252606 as select v15 from aggJoin405257355255135904 group by v15;
create or replace view aggJoin3017626194441743313 as select id as v15, title as v16, production_year as v19 from title as t, aggView7904781013239252606 where t.id=aggView7904781013239252606.v15 and production_year>2010;
create or replace view aggView579314969622469548 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin3017626194441743313 group by v15;
create or replace view aggJoin2540158973877767061 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView579314969622469548 where mc.movie_id=aggView579314969622469548.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView744737202241873920 as select v1, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin2540158973877767061 group by v1;
create or replace view aggJoin6388420135756591720 as select v28, v29, v27 from company_type as ct, aggView744737202241873920 where ct.id=aggView744737202241873920.v1 and kind= 'production companies';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin6388420135756591720;
