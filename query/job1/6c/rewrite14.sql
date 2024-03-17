create or replace view aggView7738703567967290231 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin9133954683625650424 as select movie_id as v23, v35 from movie_keyword as mk, aggView7738703567967290231 where mk.keyword_id=aggView7738703567967290231.v8;
create or replace view aggView1560289792745624742 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin850545500982246023 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView1560289792745624742 where ci.movie_id=aggView1560289792745624742.v23;
create or replace view aggView2578419370783874919 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin7895992375241987300 as select v23, v37, v36 from aggJoin850545500982246023 join aggView2578419370783874919 using(v14);
create or replace view aggView894012746468507576 as select v23, MIN(v35) as v35 from aggJoin9133954683625650424 group by v23;
create or replace view aggJoin8717436952474897926 as select v37 as v37, v36 as v36, v35 from aggJoin7895992375241987300 join aggView894012746468507576 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin8717436952474897926;
