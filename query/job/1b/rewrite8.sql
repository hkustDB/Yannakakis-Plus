create or replace view aggView973649911937630869 as select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin5082345406882204291 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView973649911937630869 where mc.movie_id=aggView973649911937630869.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView8380871957557640584 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5813491423327925577 as select v15, v9, v28, v29 from aggJoin5082345406882204291 join aggView8380871957557640584 using(v1);
create or replace view aggView4454006185326387794 as select v15, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin5813491423327925577 group by v15;
create or replace view aggJoin3460585043018272969 as select info_type_id as v3, v28, v29, v27 from movie_info_idx as mi_idx, aggView4454006185326387794 where mi_idx.movie_id=aggView4454006185326387794.v15;
create or replace view aggView7148425235324133151 as select v3, MIN(v28) as v28, MIN(v29) as v29, MIN(v27) as v27 from aggJoin3460585043018272969 group by v3;
create or replace view aggJoin2475737555058784020 as select info as v4, v28, v29, v27 from info_type as it, aggView7148425235324133151 where it.id=aggView7148425235324133151.v3 and info= 'bottom 10 rank';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin2475737555058784020;
