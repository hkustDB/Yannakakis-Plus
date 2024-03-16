create or replace view aggView6802673094208304134 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2010;
create or replace view aggJoin8502788876082710711 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView6802673094208304134 where mi_idx.movie_id=aggView6802673094208304134.v15;
create or replace view aggView9059433081019105210 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin3351418316188945377 as select v15, v28, v29 from aggJoin8502788876082710711 join aggView9059433081019105210 using(v3);
create or replace view aggView6293558633286883802 as select v15, MIN(v28) as v28, MIN(v29) as v29 from aggJoin3351418316188945377 group by v15;
create or replace view aggJoin7576006349115977319 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView6293558633286883802 where mc.movie_id=aggView6293558633286883802.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView8596392985800559412 as select v1, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin7576006349115977319 group by v1;
create or replace view aggJoin7093110610866991851 as select kind as v2, v28, v29, v27 from company_type as ct, aggView8596392985800559412 where ct.id=aggView8596392985800559412.v1 and kind= 'production companies';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin7093110610866991851;
