create or replace view aggView8789912062802424597 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin5826292276921612917 as select movie_id as v23, v36 from cast_info as ci, aggView8789912062802424597 where ci.person_id=aggView8789912062802424597.v14;
create or replace view aggView4681422003352121988 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin7435145375710217804 as select movie_id as v23, v35 from movie_keyword as mk, aggView4681422003352121988 where mk.keyword_id=aggView4681422003352121988.v8;
create or replace view aggView735632115879811231 as select v23, MIN(v36) as v36 from aggJoin5826292276921612917 group by v23;
create or replace view aggJoin6255159617324560407 as select id as v23, title as v24, v36 from title as t, aggView735632115879811231 where t.id=aggView735632115879811231.v23 and production_year>2014;
create or replace view aggView6035591274869257822 as select v23, MIN(v36) as v36, MIN(v24) as v37 from aggJoin6255159617324560407 group by v23;
create or replace view aggJoin5531205470442725506 as select v35 as v35, v36, v37 from aggJoin7435145375710217804 join aggView6035591274869257822 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin5531205470442725506;
