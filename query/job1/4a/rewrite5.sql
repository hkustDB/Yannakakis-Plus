create or replace view aggView3949109045870148627 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin4965230822070400785 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView3949109045870148627 where mi_idx.movie_id=aggView3949109045870148627.v14 and info>'5.0';
create or replace view aggView3860638842055194798 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin6936766946530502394 as select v14, v9, v27 from aggJoin4965230822070400785 join aggView3860638842055194798 using(v1);
create or replace view aggView5097065743525378026 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin6936766946530502394 group by v14;
create or replace view aggJoin6483779153822598032 as select keyword_id as v3, v27, v26 from movie_keyword as mk, aggView5097065743525378026 where mk.movie_id=aggView5097065743525378026.v14;
create or replace view aggView7299954623713423349 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3039022212660845128 as select v27, v26 from aggJoin6483779153822598032 join aggView7299954623713423349 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin3039022212660845128;
