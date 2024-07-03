create or replace view aggView2922566045111315152 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5549175670171141283 as select movie_id as v12 from movie_keyword as mk, aggView2922566045111315152 where mk.keyword_id=aggView2922566045111315152.v1;
create or replace view aggView8149997036721278006 as select v12 from aggJoin5549175670171141283 group by v12;
create or replace view aggJoin6082000812254131275 as select movie_id as v12, info as v7 from movie_info as mi, aggView8149997036721278006 where mi.movie_id=aggView8149997036721278006.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView7782008268455584778 as select v12 from aggJoin6082000812254131275 group by v12;
create or replace view aggJoin3689657909047797504 as select title as v13, production_year as v16 from title as t, aggView7782008268455584778 where t.id=aggView7782008268455584778.v12 and production_year>2005;
create or replace view aggView9166412391795818078 as select v13 from aggJoin3689657909047797504;
select MIN(v13) as v24 from aggView9166412391795818078;
