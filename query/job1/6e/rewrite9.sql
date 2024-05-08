create or replace view aggView521299874585534564 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin8672046260367443195 as select movie_id as v23, v35 from movie_keyword as mk, aggView521299874585534564 where mk.keyword_id=aggView521299874585534564.v8;
create or replace view aggView2502938289239070128 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin313451653006666779 as select movie_id as v23, v36 from cast_info as ci, aggView2502938289239070128 where ci.person_id=aggView2502938289239070128.v14;
create or replace view aggView7039822677247375768 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin6540530177082532695 as select v23, v35, v37 from aggJoin8672046260367443195 join aggView7039822677247375768 using(v23);
create or replace view aggView6390224426525483971 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin6540530177082532695 group by v23;
create or replace view aggJoin1034283883228840624 as select v36 as v36, v35, v37 from aggJoin313451653006666779 join aggView6390224426525483971 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1034283883228840624;
