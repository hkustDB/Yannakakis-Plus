create or replace view aggView5813063530595534024 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin7860255247907973246 as select movie_id as v23, v36 from cast_info as ci, aggView5813063530595534024 where ci.person_id=aggView5813063530595534024.v14;
create or replace view aggView7161574857959154634 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin7505499292684508931 as select movie_id as v23, v35 from movie_keyword as mk, aggView7161574857959154634 where mk.keyword_id=aggView7161574857959154634.v8;
create or replace view aggView7478155214894408061 as select v23, MIN(v36) as v36 from aggJoin7860255247907973246 group by v23;
create or replace view aggJoin4949901928985979664 as select id as v23, title as v24, v36 from title as t, aggView7478155214894408061 where t.id=aggView7478155214894408061.v23 and production_year>2014;
create or replace view aggView2209008560768162953 as select v23, MIN(v35) as v35 from aggJoin7505499292684508931 group by v23;
create or replace view aggJoin2624556574470169770 as select v24, v36 as v36, v35 from aggJoin4949901928985979664 join aggView2209008560768162953 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin2624556574470169770;
