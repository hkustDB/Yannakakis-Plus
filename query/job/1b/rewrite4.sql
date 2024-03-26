create or replace view aggView2497051014966419906 as select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin6201217963495492340 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView2497051014966419906 where mc.movie_id=aggView2497051014966419906.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView3630513088704255792 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin8677930395114562929 as select movie_id as v15 from movie_info_idx as mi_idx, aggView3630513088704255792 where mi_idx.info_type_id=aggView3630513088704255792.v3;
create or replace view aggView6129950987756423149 as select v15 from aggJoin8677930395114562929 group by v15;
create or replace view aggJoin4474499699097061729 as select v1, v9, v28 as v28, v29 as v29 from aggJoin6201217963495492340 join aggView6129950987756423149 using(v15);
create or replace view aggView2201383435981426229 as select v1, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin4474499699097061729 group by v1;
create or replace view aggJoin4492245963688420017 as select kind as v2, v28, v29, v27 from company_type as ct, aggView2201383435981426229 where ct.id=aggView2201383435981426229.v1 and kind= 'production companies';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin4492245963688420017;
