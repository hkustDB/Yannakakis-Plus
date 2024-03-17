create or replace view aggView7430479046253565061 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin9167806050101880263 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView7430479046253565061 where mk.movie_id=aggView7430479046253565061.v14;
create or replace view aggView8332171176743450016 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2797414210221593939 as select v14, v27 from aggJoin9167806050101880263 join aggView8332171176743450016 using(v3);
create or replace view aggView9184428144797359448 as select v14, MIN(v27) as v27 from aggJoin2797414210221593939 group by v14;
create or replace view aggJoin3489034737197288974 as select info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView9184428144797359448 where mi_idx.movie_id=aggView9184428144797359448.v14 and info>'2.0';
create or replace view aggView691758570730284158 as select v1, MIN(v27) as v27, MIN(v9) as v26 from aggJoin3489034737197288974 group by v1;
create or replace view aggJoin8647768962717737380 as select v27, v26 from info_type as it, aggView691758570730284158 where it.id=aggView691758570730284158.v1 and info= 'rating';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin8647768962717737380;
