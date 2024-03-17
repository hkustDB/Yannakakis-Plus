create or replace view aggView2716039737838315468 as select id as v15, title as v28, production_year as v29 from title as t;
create or replace view aggJoin1122874385042887188 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView2716039737838315468 where mi_idx.movie_id=aggView2716039737838315468.v15;
create or replace view aggView3426027554164198645 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin1788282350050540795 as select v15, v28, v29 from aggJoin1122874385042887188 join aggView3426027554164198645 using(v3);
create or replace view aggView437249005533907764 as select v15, MIN(v28) as v28, MIN(v29) as v29 from aggJoin1788282350050540795 group by v15;
create or replace view aggJoin8133389216812971971 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView437249005533907764 where mc.movie_id=aggView437249005533907764.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView8183928271623494669 as select v1, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin8133389216812971971 group by v1;
create or replace view aggJoin6480669375749977103 as select kind as v2, v28, v29, v27 from company_type as ct, aggView8183928271623494669 where ct.id=aggView8183928271623494669.v1 and kind= 'production companies';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin6480669375749977103;
