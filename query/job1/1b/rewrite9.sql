create or replace view aggView4481744152366292604 as select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin4925082687174147965 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView4481744152366292604 where mc.movie_id=aggView4481744152366292604.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView7715525204170638642 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin2577970677401962321 as select movie_id as v15 from movie_info_idx as mi_idx, aggView7715525204170638642 where mi_idx.info_type_id=aggView7715525204170638642.v3;
create or replace view aggView7658531496771850570 as select v15 from aggJoin2577970677401962321 group by v15;
create or replace view aggJoin5057617351013695040 as select v1, v9, v28 as v28, v29 as v29 from aggJoin4925082687174147965 join aggView7658531496771850570 using(v15);
create or replace view aggView8934837581590623359 as select v1, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin5057617351013695040 group by v1;
create or replace view aggJoin3233071046296948384 as select kind as v2, v28, v29, v27 from company_type as ct, aggView8934837581590623359 where ct.id=aggView8934837581590623359.v1 and kind= 'production companies';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin3233071046296948384;
