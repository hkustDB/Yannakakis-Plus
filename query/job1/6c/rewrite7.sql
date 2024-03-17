create or replace view aggView2728676010835284272 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin1305551192794796132 as select movie_id as v23, v35 from movie_keyword as mk, aggView2728676010835284272 where mk.keyword_id=aggView2728676010835284272.v8;
create or replace view aggView6845528402902061746 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8039343372285242320 as select movie_id as v23, v36 from cast_info as ci, aggView6845528402902061746 where ci.person_id=aggView6845528402902061746.v14;
create or replace view aggView3857866555294156273 as select v23, MIN(v35) as v35 from aggJoin1305551192794796132 group by v23;
create or replace view aggJoin7910205700617493544 as select v23, v36 as v36, v35 from aggJoin8039343372285242320 join aggView3857866555294156273 using(v23);
create or replace view aggView1564478742048304014 as select v23, MIN(v36) as v36, MIN(v35) as v35 from aggJoin7910205700617493544 group by v23;
create or replace view aggJoin1937710676808760228 as select title as v24, v36, v35 from title as t, aggView1564478742048304014 where t.id=aggView1564478742048304014.v23 and production_year>2014;
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin1937710676808760228;
