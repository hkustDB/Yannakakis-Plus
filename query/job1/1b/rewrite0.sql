create or replace view aggView8624377139047891394 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5356918332923978567 as select movie_id as v15, note as v9 from movie_companies as mc, aggView8624377139047891394 where mc.company_type_id=aggView8624377139047891394.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView6968986697947921695 as select v15, MIN(v9) as v27 from aggJoin5356918332923978567 group by v15;
create or replace view aggJoin2078935077911692738 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView6968986697947921695 where t.id=aggView6968986697947921695.v15 and production_year<=2010 and production_year>=2005;
create or replace view aggView2310370525803251696 as select v15, MIN(v27) as v27, MIN(v16) as v28, MIN(v19) as v29 from aggJoin2078935077911692738 group by v15;
create or replace view aggJoin4824970448126473515 as select info_type_id as v3, v27, v28, v29 from movie_info_idx as mi_idx, aggView2310370525803251696 where mi_idx.movie_id=aggView2310370525803251696.v15;
create or replace view aggView7026420558483827006 as select v3, MIN(v27) as v27, MIN(v28) as v28, MIN(v29) as v29 from aggJoin4824970448126473515 group by v3;
create or replace view aggJoin1024790032860593467 as select v27, v28, v29 from info_type as it, aggView7026420558483827006 where it.id=aggView7026420558483827006.v3 and info= 'bottom 10 rank';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin1024790032860593467;
