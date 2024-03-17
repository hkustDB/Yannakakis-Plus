create or replace view aggView3627463798393615281 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8046743690799474517 as select movie_id as v15, note as v9 from movie_companies as mc, aggView3627463798393615281 where mc.company_type_id=aggView3627463798393615281.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView9000860041880159950 as select v15, MIN(v9) as v27 from aggJoin8046743690799474517 group by v15;
create or replace view aggJoin2935888678696470327 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView9000860041880159950 where t.id=aggView9000860041880159950.v15 and production_year<=2010 and production_year>=2005;
create or replace view aggView1344567931845824951 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin5453389514308247584 as select movie_id as v15 from movie_info_idx as mi_idx, aggView1344567931845824951 where mi_idx.info_type_id=aggView1344567931845824951.v3;
create or replace view aggView8379277815803954664 as select v15 from aggJoin5453389514308247584 group by v15;
create or replace view aggJoin3841652473634206570 as select v16, v19, v27 as v27 from aggJoin2935888678696470327 join aggView8379277815803954664 using(v15);
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin3841652473634206570;
