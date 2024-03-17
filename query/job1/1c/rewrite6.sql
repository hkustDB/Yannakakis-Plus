create or replace view aggView3495372070486908437 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin8620440117815235550 as select movie_id as v15 from movie_info_idx as mi_idx, aggView3495372070486908437 where mi_idx.info_type_id=aggView3495372070486908437.v3;
create or replace view aggView3755278832320702320 as select v15 from aggJoin8620440117815235550 group by v15;
create or replace view aggJoin3034382036651855836 as select id as v15, title as v16, production_year as v19 from title as t, aggView3755278832320702320 where t.id=aggView3755278832320702320.v15 and production_year>2010;
create or replace view aggView5927666598886318750 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin3034382036651855836 group by v15;
create or replace view aggJoin3580140792190577468 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView5927666598886318750 where mc.movie_id=aggView5927666598886318750.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView4356010218495517361 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4294997246932982969 as select v9, v28, v29 from aggJoin3580140792190577468 join aggView4356010218495517361 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin4294997246932982969;
