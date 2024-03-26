create or replace view aggView5167186895632431846 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6827785018457991493 as select movie_id as v12 from movie_keyword as mk, aggView5167186895632431846 where mk.keyword_id=aggView5167186895632431846.v1;
create or replace view aggView7980637405992789243 as select v12 from aggJoin6827785018457991493 group by v12;
create or replace view aggJoin1676636557903716283 as select movie_id as v12, info as v7 from movie_info as mi, aggView7980637405992789243 where mi.movie_id=aggView7980637405992789243.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView3292974805180137707 as select v12 from aggJoin1676636557903716283 group by v12;
create or replace view aggJoin5213204697466231517 as select title as v13 from title as t, aggView3292974805180137707 where t.id=aggView3292974805180137707.v12 and production_year>1990;
select MIN(v13) as v24 from aggJoin5213204697466231517;
