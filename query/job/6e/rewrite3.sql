create or replace view aggView4977386313540966427 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4016718505831483938 as select movie_id as v23, v36 from cast_info as ci, aggView4977386313540966427 where ci.person_id=aggView4977386313540966427.v14;
create or replace view aggView2932125915184144726 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin4974062287285165936 as select movie_id as v23, v35 from movie_keyword as mk, aggView2932125915184144726 where mk.keyword_id=aggView2932125915184144726.v8;
create or replace view aggView7224836739442544847 as select v23, MIN(v36) as v36 from aggJoin4016718505831483938 group by v23;
create or replace view aggJoin5835938339161340618 as select id as v23, title as v24, v36 from title as t, aggView7224836739442544847 where t.id=aggView7224836739442544847.v23 and production_year>2000;
create or replace view aggView7307281096383037668 as select v23, MIN(v35) as v35 from aggJoin4974062287285165936 group by v23;
create or replace view aggJoin5686210378003560437 as select v24, v36 as v36, v35 from aggJoin5835938339161340618 join aggView7307281096383037668 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin5686210378003560437;
