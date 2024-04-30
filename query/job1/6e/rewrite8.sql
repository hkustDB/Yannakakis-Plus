create or replace view aggView6495653430625683269 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin5664915514540316195 as select movie_id as v23, v35 from movie_keyword as mk, aggView6495653430625683269 where mk.keyword_id=aggView6495653430625683269.v8;
create or replace view aggView874880789622803408 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3110467616783507587 as select movie_id as v23, v36 from cast_info as ci, aggView874880789622803408 where ci.person_id=aggView874880789622803408.v14;
create or replace view aggView217668557717811150 as select v23, MIN(v35) as v35 from aggJoin5664915514540316195 group by v23;
create or replace view aggJoin6609026827029094493 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView217668557717811150 where t.id=aggView217668557717811150.v23 and production_year>2000;
create or replace view aggView7291914477464011634 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin6609026827029094493 group by v23;
create or replace view aggJoin7337467255605984133 as select v36 as v36, v35, v37 from aggJoin3110467616783507587 join aggView7291914477464011634 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin7337467255605984133;
