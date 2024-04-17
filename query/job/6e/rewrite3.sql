create or replace view aggView5237834698584750063 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin4877157812332796028 as select movie_id as v23, v35 from movie_keyword as mk, aggView5237834698584750063 where mk.keyword_id=aggView5237834698584750063.v8;
create or replace view aggView6728136385653789251 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2465483460082001562 as select movie_id as v23, v36 from cast_info as ci, aggView6728136385653789251 where ci.person_id=aggView6728136385653789251.v14;
create or replace view aggView187818944766879134 as select v23, MIN(v35) as v35 from aggJoin4877157812332796028 group by v23,v35;
create or replace view aggJoin7353726928617112731 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView187818944766879134 where t.id=aggView187818944766879134.v23 and production_year>2000;
create or replace view aggView4630624887753033780 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin7353726928617112731 group by v23,v35;
create or replace view aggJoin2655903368114184865 as select v36 as v36, v35, v37 from aggJoin2465483460082001562 join aggView4630624887753033780 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin2655903368114184865;
