create or replace view aggView8892327130370225200 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin3330136446501543088 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView8892327130370225200 where mk.movie_id=aggView8892327130370225200.v23;
create or replace view aggView3301849092551983570 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin7038938235341975049 as select v23, v37 from aggJoin3330136446501543088 join aggView3301849092551983570 using(v8);
create or replace view aggView299143625306990607 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2397401622551016099 as select movie_id as v23, v36 from cast_info as ci, aggView299143625306990607 where ci.person_id=aggView299143625306990607.v14;
create or replace view aggView2514528670905674803 as select v23, MIN(v36) as v36 from aggJoin2397401622551016099 group by v23;
create or replace view aggJoin4171525749424850915 as select v37 as v37, v36 from aggJoin7038938235341975049 join aggView2514528670905674803 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4171525749424850915;
