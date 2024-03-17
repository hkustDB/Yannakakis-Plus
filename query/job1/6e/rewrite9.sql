create or replace view aggView3113021143323472176 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3402732707210213757 as select movie_id as v23, v36 from cast_info as ci, aggView3113021143323472176 where ci.person_id=aggView3113021143323472176.v14;
create or replace view aggView2668494329019992512 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin5957520452021083289 as select movie_id as v23, v35 from movie_keyword as mk, aggView2668494329019992512 where mk.keyword_id=aggView2668494329019992512.v8;
create or replace view aggView1476089338308975442 as select v23, MIN(v36) as v36 from aggJoin3402732707210213757 group by v23;
create or replace view aggJoin6450544908040680983 as select v23, v35 as v35, v36 from aggJoin5957520452021083289 join aggView1476089338308975442 using(v23);
create or replace view aggView2172763563445853222 as select v23, MIN(v35) as v35, MIN(v36) as v36 from aggJoin6450544908040680983 group by v23;
create or replace view aggJoin6560034942741846306 as select title as v24, v35, v36 from title as t, aggView2172763563445853222 where t.id=aggView2172763563445853222.v23 and production_year>2000;
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin6560034942741846306;
