create or replace view aggView3459352226955938282 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin6484341981775745724 as select movie_id as v23, v35 from movie_keyword as mk, aggView3459352226955938282 where mk.keyword_id=aggView3459352226955938282.v8;
create or replace view aggView8833807542880062448 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin1220894046510110148 as select movie_id as v23, v36 from cast_info as ci, aggView8833807542880062448 where ci.person_id=aggView8833807542880062448.v14;
create or replace view aggView2645374292594213742 as select v23, MIN(v35) as v35 from aggJoin6484341981775745724 group by v23;
create or replace view aggJoin1883629824243897968 as select v23, v36 as v36, v35 from aggJoin1220894046510110148 join aggView2645374292594213742 using(v23);
create or replace view aggView8347933867269659783 as select v23, MIN(v36) as v36, MIN(v35) as v35 from aggJoin1883629824243897968 group by v23;
create or replace view aggJoin7177981823789321577 as select title as v24, v36, v35 from title as t, aggView8347933867269659783 where t.id=aggView8347933867269659783.v23 and production_year>2000;
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin7177981823789321577;
