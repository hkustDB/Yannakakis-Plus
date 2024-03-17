create or replace view aggView3988513884852992690 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2732885587923709865 as select movie_id as v23, v36 from cast_info as ci, aggView3988513884852992690 where ci.person_id=aggView3988513884852992690.v14;
create or replace view aggView6231929457789509552 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin5037481895624398994 as select movie_id as v23, v35 from movie_keyword as mk, aggView6231929457789509552 where mk.keyword_id=aggView6231929457789509552.v8;
create or replace view aggView8411327877286362455 as select v23, MIN(v35) as v35 from aggJoin5037481895624398994 group by v23;
create or replace view aggJoin4653692205396989728 as select v23, v36 as v36, v35 from aggJoin2732885587923709865 join aggView8411327877286362455 using(v23);
create or replace view aggView2762016084403801045 as select v23, MIN(v36) as v36, MIN(v35) as v35 from aggJoin4653692205396989728 group by v23;
create or replace view aggJoin3425236581597864151 as select title as v24, v36, v35 from title as t, aggView2762016084403801045 where t.id=aggView2762016084403801045.v23 and production_year>2000;
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin3425236581597864151;
