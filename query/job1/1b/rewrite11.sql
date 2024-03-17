create or replace view aggView6242272056817652863 as select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin4047351775566157470 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView6242272056817652863 where mc.movie_id=aggView6242272056817652863.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView8034579829310388923 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6932458613036352083 as select v15, v9, v28, v29 from aggJoin4047351775566157470 join aggView8034579829310388923 using(v1);
create or replace view aggView4564648236709213928 as select v15, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin6932458613036352083 group by v15;
create or replace view aggJoin2079407021391381801 as select info_type_id as v3, v28, v29, v27 from movie_info_idx as mi_idx, aggView4564648236709213928 where mi_idx.movie_id=aggView4564648236709213928.v15;
create or replace view aggView821664043787030302 as select v3, MIN(v28) as v28, MIN(v29) as v29, MIN(v27) as v27 from aggJoin2079407021391381801 group by v3;
create or replace view aggJoin5759828503703742109 as select info as v4, v28, v29, v27 from info_type as it, aggView821664043787030302 where it.id=aggView821664043787030302.v3 and info= 'bottom 10 rank';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin5759828503703742109;
