create or replace view aggView8261964132405850186 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin4561619608413121577 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView8261964132405850186 where mi.movie_id=aggView8261964132405850186.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView3664168083813872074 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1109680229176918474 as select movie_id as v12 from movie_keyword as mk, aggView3664168083813872074 where mk.keyword_id=aggView3664168083813872074.v1;
create or replace view aggView1803111238760811550 as select v12 from aggJoin1109680229176918474 group by v12;
create or replace view aggJoin8394086651666615177 as select v7, v24 as v24 from aggJoin4561619608413121577 join aggView1803111238760811550 using(v12);
select MIN(v24) as v24 from aggJoin8394086651666615177;
