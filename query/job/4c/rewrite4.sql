create or replace view aggView7746030593764998352 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin5005433898722339478 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView7746030593764998352 where mi_idx.movie_id=aggView7746030593764998352.v14 and info>'2.0';
create or replace view aggView4395455556693105906 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1210487861261252075 as select movie_id as v14 from movie_keyword as mk, aggView4395455556693105906 where mk.keyword_id=aggView4395455556693105906.v3;
create or replace view aggView8652119580284849145 as select v14 from aggJoin1210487861261252075 group by v14;
create or replace view aggJoin353000543459478971 as select v1, v9, v27 as v27 from aggJoin5005433898722339478 join aggView8652119580284849145 using(v14);
create or replace view aggView8247573660336914925 as select v1, MIN(v27) as v27, MIN(v9) as v26 from aggJoin353000543459478971 group by v1;
create or replace view aggJoin6260637517125837536 as select v27, v26 from info_type as it, aggView8247573660336914925 where it.id=aggView8247573660336914925.v1 and info= 'rating';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin6260637517125837536;
