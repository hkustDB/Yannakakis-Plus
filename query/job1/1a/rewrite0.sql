create or replace view aggView6632256843532884583 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8002700916076760497 as select movie_id as v15, note as v9 from movie_companies as mc, aggView6632256843532884583 where mc.company_type_id=aggView6632256843532884583.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView8149707017325274781 as select v15, MIN(v9) as v27 from aggJoin8002700916076760497 group by v15;
create or replace view aggJoin3614785937909902052 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView8149707017325274781 where t.id=aggView8149707017325274781.v15;
create or replace view aggView7235576109140070902 as select v15, MIN(v27) as v27, MIN(v16) as v28, MIN(v19) as v29 from aggJoin3614785937909902052 group by v15;
create or replace view aggJoin2292227912798977708 as select info_type_id as v3, v27, v28, v29 from movie_info_idx as mi_idx, aggView7235576109140070902 where mi_idx.movie_id=aggView7235576109140070902.v15;
create or replace view aggView6657941291393824061 as select v3, MIN(v27) as v27, MIN(v28) as v28, MIN(v29) as v29 from aggJoin2292227912798977708 group by v3;
create or replace view aggJoin6853632273677875914 as select info as v4, v27, v28, v29 from info_type as it, aggView6657941291393824061 where it.id=aggView6657941291393824061.v3 and info= 'top 250 rank';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin6853632273677875914;
