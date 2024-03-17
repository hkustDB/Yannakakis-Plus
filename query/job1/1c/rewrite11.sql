create or replace view aggView5967736334600297394 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin5562777099453214547 as select movie_id as v15 from movie_info_idx as mi_idx, aggView5967736334600297394 where mi_idx.info_type_id=aggView5967736334600297394.v3;
create or replace view aggView5993968388691490225 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2156630972329004491 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5993968388691490225 where mc.company_type_id=aggView5993968388691490225.v1 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView2002678194820945473 as select v15, MIN(v9) as v27 from aggJoin2156630972329004491 group by v15;
create or replace view aggJoin219244952582261148 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView2002678194820945473 where t.id=aggView2002678194820945473.v15 and production_year>2010;
create or replace view aggView8413884573454271305 as select v15, MIN(v27) as v27, MIN(v16) as v28, MIN(v19) as v29 from aggJoin219244952582261148 group by v15;
create or replace view aggJoin2558475291415352547 as select v27, v28, v29 from aggJoin5562777099453214547 join aggView8413884573454271305 using(v15);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin2558475291415352547;
