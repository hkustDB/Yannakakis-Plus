create or replace view aggView7649028892795785917 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2010;
create or replace view aggJoin3922890828271158831 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView7649028892795785917 where mi_idx.movie_id=aggView7649028892795785917.v15;
create or replace view aggView3029210320345730585 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3487737207410944136 as select movie_id as v15, note as v9 from movie_companies as mc, aggView3029210320345730585 where mc.company_type_id=aggView3029210320345730585.v1 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView7781839842924800823 as select v15, MIN(v9) as v27 from aggJoin3487737207410944136 group by v15;
create or replace view aggJoin3552478413309416393 as select v3, v28 as v28, v29 as v29, v27 from aggJoin3922890828271158831 join aggView7781839842924800823 using(v15);
create or replace view aggView2357419508704562247 as select v3, MIN(v28) as v28, MIN(v29) as v29, MIN(v27) as v27 from aggJoin3552478413309416393 group by v3;
create or replace view aggJoin4441496150052942657 as select info as v4, v28, v29, v27 from info_type as it, aggView2357419508704562247 where it.id=aggView2357419508704562247.v3 and info= 'top 250 rank';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin4441496150052942657;
