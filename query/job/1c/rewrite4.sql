create or replace view aggView2186639189191406319 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2010;
create or replace view aggJoin2819730271625234537 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView2186639189191406319 where mc.movie_id=aggView2186639189191406319.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView3911693258201588184 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin8925072771638350676 as select movie_id as v15 from movie_info_idx as mi_idx, aggView3911693258201588184 where mi_idx.info_type_id=aggView3911693258201588184.v3;
create or replace view aggView5039300108964817479 as select v15 from aggJoin8925072771638350676 group by v15;
create or replace view aggJoin4576503015860022029 as select v1, v9, v28 as v28, v29 as v29 from aggJoin2819730271625234537 join aggView5039300108964817479 using(v15);
create or replace view aggView511141015990357172 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin785416491898676864 as select v9, v28, v29 from aggJoin4576503015860022029 join aggView511141015990357172 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin785416491898676864;
