create or replace view aggView4419355176676344770 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2010;
create or replace view aggJoin7792849427673228369 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView4419355176676344770 where mi_idx.movie_id=aggView4419355176676344770.v15;
create or replace view aggView8658624166830171257 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8143629719529590470 as select movie_id as v15, note as v9 from movie_companies as mc, aggView8658624166830171257 where mc.company_type_id=aggView8658624166830171257.v1 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView4040541740397532497 as select v15, MIN(v9) as v27 from aggJoin8143629719529590470 group by v15;
create or replace view aggJoin2095622940037807068 as select v3, v28 as v28, v29 as v29, v27 from aggJoin7792849427673228369 join aggView4040541740397532497 using(v15);
create or replace view aggView2796185697246012215 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin8024938106886805538 as select v28, v29, v27 from aggJoin2095622940037807068 join aggView2796185697246012215 using(v3);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin8024938106886805538;
