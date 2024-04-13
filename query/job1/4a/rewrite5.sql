create or replace view aggView1541950906974714357 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin6425598134973588892 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView1541950906974714357 where mi_idx.movie_id=aggView1541950906974714357.v14 and info>'5.0';
create or replace view aggView7564743936463810503 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin1526584645965843350 as select v14, v9, v27 from aggJoin6425598134973588892 join aggView7564743936463810503 using(v1);
create or replace view aggView7759101279149366207 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin1526584645965843350 group by v14,v27;
create or replace view aggJoin1482474711934642563 as select keyword_id as v3, v27, v26 from movie_keyword as mk, aggView7759101279149366207 where mk.movie_id=aggView7759101279149366207.v14;
create or replace view aggView7866348412211369045 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5908801226238010038 as select v27, v26 from aggJoin1482474711934642563 join aggView7866348412211369045 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin5908801226238010038;
