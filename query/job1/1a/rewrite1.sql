create or replace view aggView7406733934307273697 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1575159254629791574 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7406733934307273697 where mc.company_type_id=aggView7406733934307273697.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView2654738385921779832 as select v15, MIN(v9) as v27 from aggJoin1575159254629791574 group by v15;
create or replace view aggJoin91168958579104782 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView2654738385921779832 where t.id=aggView2654738385921779832.v15;
create or replace view aggView8749798007245249751 as select v15, MIN(v27) as v27, MIN(v16) as v28, MIN(v19) as v29 from aggJoin91168958579104782 group by v15;
create or replace view aggJoin4454945827939076080 as select info_type_id as v3, v27, v28, v29 from movie_info_idx as mi_idx, aggView8749798007245249751 where mi_idx.movie_id=aggView8749798007245249751.v15;
create or replace view aggView3421340515643352059 as select v3, MIN(v27) as v27, MIN(v28) as v28, MIN(v29) as v29 from aggJoin4454945827939076080 group by v3;
create or replace view aggJoin3897429404290120055 as select info as v4, v27, v28, v29 from info_type as it, aggView3421340515643352059 where it.id=aggView3421340515643352059.v3 and info= 'top 250 rank';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin3897429404290120055;
