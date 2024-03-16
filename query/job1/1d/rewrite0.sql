create or replace view aggView741982321672486560 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin1163348131368078244 as select movie_id as v15 from movie_info_idx as mi_idx, aggView741982321672486560 where mi_idx.info_type_id=aggView741982321672486560.v3;
create or replace view aggView8641066326766948160 as select v15 from aggJoin1163348131368078244 group by v15;
create or replace view aggJoin4254229623055397988 as select id as v15, title as v16, production_year as v19 from title as t, aggView8641066326766948160 where t.id=aggView8641066326766948160.v15 and production_year>2000;
create or replace view aggView7043055849653698922 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin4254229623055397988 group by v15;
create or replace view aggJoin6459516404381287630 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView7043055849653698922 where mc.movie_id=aggView7043055849653698922.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView5202888212612703257 as select v1, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin6459516404381287630 group by v1;
create or replace view aggJoin8046793090929543220 as select v28, v29, v27 from company_type as ct, aggView5202888212612703257 where ct.id=aggView5202888212612703257.v1 and kind= 'production companies';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin8046793090929543220;
