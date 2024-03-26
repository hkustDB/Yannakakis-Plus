create or replace view aggView797672144537957834 as select id as v15, title as v27 from title as t where production_year>2005;
create or replace view aggJoin8501614808968819553 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView797672144537957834 where mi.movie_id=aggView797672144537957834.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView2397460701582193890 as select id as v3 from info_type as it;
create or replace view aggJoin7972459644547501710 as select v15, v13, v27 from aggJoin8501614808968819553 join aggView2397460701582193890 using(v3);
create or replace view aggView2968726159713572911 as select v15, MIN(v27) as v27 from aggJoin7972459644547501710 group by v15;
create or replace view aggJoin6860132584400451218 as select company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView2968726159713572911 where mc.movie_id=aggView2968726159713572911.v15 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView2024468686309037721 as select v1, MIN(v27) as v27 from aggJoin6860132584400451218 group by v1;
create or replace view aggJoin8430663562412450530 as select kind as v2, v27 from company_type as ct, aggView2024468686309037721 where ct.id=aggView2024468686309037721.v1 and kind= 'production companies';
select MIN(v27) as v27 from aggJoin8430663562412450530;
