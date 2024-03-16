create or replace view aggView4470252007672904806 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin3220218666149568701 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView4470252007672904806 where mk.movie_id=aggView4470252007672904806.v23;
create or replace view aggView8619380782690772419 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin255052833179834371 as select v23, v37 from aggJoin3220218666149568701 join aggView8619380782690772419 using(v8);
create or replace view aggView3023662011916184186 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4138407092179431423 as select movie_id as v23, v36 from cast_info as ci, aggView3023662011916184186 where ci.person_id=aggView3023662011916184186.v14;
create or replace view aggView8313596819161099551 as select v23, MIN(v37) as v37 from aggJoin255052833179834371 group by v23;
create or replace view aggJoin8494786786101641348 as select v36 as v36, v37 from aggJoin4138407092179431423 join aggView8313596819161099551 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin8494786786101641348;
