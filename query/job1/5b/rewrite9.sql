create or replace view aggView506478841585160094 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin9159766620027852638 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView506478841585160094 where mc.movie_id=aggView506478841585160094.v15 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView8890141254589846029 as select id as v3 from info_type as it;
create or replace view aggJoin4761466152898620823 as select movie_id as v15, info as v13 from movie_info as mi, aggView8890141254589846029 where mi.info_type_id=aggView8890141254589846029.v3 and info IN ('USA','America');
create or replace view aggView8858096989008391112 as select v15 from aggJoin4761466152898620823 group by v15;
create or replace view aggJoin1440867633609797686 as select v1, v9, v27 as v27 from aggJoin9159766620027852638 join aggView8858096989008391112 using(v15);
create or replace view aggView735383159363327524 as select v1, MIN(v27) as v27 from aggJoin1440867633609797686 group by v1;
create or replace view aggJoin1080898534424272252 as select kind as v2, v27 from company_type as ct, aggView735383159363327524 where ct.id=aggView735383159363327524.v1 and kind= 'production companies';
select MIN(v27) as v27 from aggJoin1080898534424272252;
