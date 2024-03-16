create or replace view aggView2135648824135202508 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2010;
create or replace view aggJoin2661670003391880953 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView2135648824135202508 where mi_idx.movie_id=aggView2135648824135202508.v15;
create or replace view aggView8261546879973007557 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2729724018576237518 as select movie_id as v15, note as v9 from movie_companies as mc, aggView8261546879973007557 where mc.company_type_id=aggView8261546879973007557.v1 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView5442132012838167367 as select v15, MIN(v9) as v27 from aggJoin2729724018576237518 group by v15;
create or replace view aggJoin3463598741296790198 as select v3, v28 as v28, v29 as v29, v27 from aggJoin2661670003391880953 join aggView5442132012838167367 using(v15);
create or replace view aggView6902981486132770923 as select v3, MIN(v28) as v28, MIN(v29) as v29, MIN(v27) as v27 from aggJoin3463598741296790198 group by v3;
create or replace view aggJoin4417266053183259325 as select info as v4, v28, v29, v27 from info_type as it, aggView6902981486132770923 where it.id=aggView6902981486132770923.v3 and info= 'top 250 rank';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin4417266053183259325;
