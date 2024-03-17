create or replace view aggView2718498337137191027 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin2896467403361510947 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView2718498337137191027 where mk.movie_id=aggView2718498337137191027.v23;
create or replace view aggView8085877823701835485 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin9188403021767311546 as select v23, v37 from aggJoin2896467403361510947 join aggView8085877823701835485 using(v8);
create or replace view aggView3036243453929720298 as select v23, MIN(v37) as v37 from aggJoin9188403021767311546 group by v23;
create or replace view aggJoin3570479647815960854 as select person_id as v14, v37 from cast_info as ci, aggView3036243453929720298 where ci.movie_id=aggView3036243453929720298.v23;
create or replace view aggView2273069418851097393 as select v14, MIN(v37) as v37 from aggJoin3570479647815960854 group by v14;
create or replace view aggJoin5729046540042138255 as select name as v15, v37 from name as n, aggView2273069418851097393 where n.id=aggView2273069418851097393.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin5729046540042138255;
