create or replace view aggView1960828347196536763 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin1374922932339651009 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView1960828347196536763 where mc.movie_id=aggView1960828347196536763.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView2109273004694053327 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8848982817486456487 as select v15, v9, v28, v29 from aggJoin1374922932339651009 join aggView2109273004694053327 using(v1);
create or replace view aggView5865901263795841 as select v15, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin8848982817486456487 group by v15;
create or replace view aggJoin5735482145009781747 as select info_type_id as v3, v28, v29, v27 from movie_info_idx as mi_idx, aggView5865901263795841 where mi_idx.movie_id=aggView5865901263795841.v15;
create or replace view aggView4272797985126946782 as select v3, MIN(v28) as v28, MIN(v29) as v29, MIN(v27) as v27 from aggJoin5735482145009781747 group by v3;
create or replace view aggJoin1416658735371964271 as select info as v4, v28, v29, v27 from info_type as it, aggView4272797985126946782 where it.id=aggView4272797985126946782.v3 and info= 'bottom 10 rank';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin1416658735371964271;
