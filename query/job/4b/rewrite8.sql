create or replace view aggView2956168865179379095 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin6006464298467778187 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView2956168865179379095 where mi_idx.movie_id=aggView2956168865179379095.v14 and info>'9.0';
create or replace view aggView8501453501106436182 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin8748299325564108607 as select v14, v9, v27 from aggJoin6006464298467778187 join aggView8501453501106436182 using(v1);
create or replace view aggView7049510649439648523 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin8748299325564108607 group by v14;
create or replace view aggJoin1724600684993280091 as select keyword_id as v3, v27, v26 from movie_keyword as mk, aggView7049510649439648523 where mk.movie_id=aggView7049510649439648523.v14;
create or replace view aggView4931949840267976674 as select v3, MIN(v27) as v27, MIN(v26) as v26 from aggJoin1724600684993280091 group by v3;
create or replace view aggJoin7324802003262737431 as select v27, v26 from keyword as k, aggView4931949840267976674 where k.id=aggView4931949840267976674.v3 and keyword LIKE '%sequel%';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin7324802003262737431;
