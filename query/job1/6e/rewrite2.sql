create or replace view aggView7822145817174891700 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin7219018071747159684 as select movie_id as v23, v35 from movie_keyword as mk, aggView7822145817174891700 where mk.keyword_id=aggView7822145817174891700.v8;
create or replace view aggView6879507005943107652 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4975704061603460749 as select movie_id as v23, v36 from cast_info as ci, aggView6879507005943107652 where ci.person_id=aggView6879507005943107652.v14;
create or replace view aggView1348685552369937047 as select v23, MIN(v36) as v36 from aggJoin4975704061603460749 group by v23;
create or replace view aggJoin6848338891841413075 as select v23, v35 as v35, v36 from aggJoin7219018071747159684 join aggView1348685552369937047 using(v23);
create or replace view aggView8466873437096060288 as select v23, MIN(v35) as v35, MIN(v36) as v36 from aggJoin6848338891841413075 group by v23;
create or replace view aggJoin3649999997615795255 as select title as v24, v35, v36 from title as t, aggView8466873437096060288 where t.id=aggView8466873437096060288.v23 and production_year>2000;
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin3649999997615795255;
