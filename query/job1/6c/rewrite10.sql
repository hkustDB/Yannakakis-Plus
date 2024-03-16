create or replace view aggView7600707963912947408 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2436753325649086532 as select movie_id as v23, v36 from cast_info as ci, aggView7600707963912947408 where ci.person_id=aggView7600707963912947408.v14;
create or replace view aggView7066981010365243839 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin1661804923010052103 as select movie_id as v23, v35 from movie_keyword as mk, aggView7066981010365243839 where mk.keyword_id=aggView7066981010365243839.v8;
create or replace view aggView271847297752756991 as select v23, MIN(v35) as v35 from aggJoin1661804923010052103 group by v23;
create or replace view aggJoin5179290630277886088 as select v23, v36 as v36, v35 from aggJoin2436753325649086532 join aggView271847297752756991 using(v23);
create or replace view aggView2413357749363687374 as select v23, MIN(v36) as v36, MIN(v35) as v35 from aggJoin5179290630277886088 group by v23;
create or replace view aggJoin4574403893830526811 as select title as v24, v36, v35 from title as t, aggView2413357749363687374 where t.id=aggView2413357749363687374.v23 and production_year>2014;
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin4574403893830526811;
