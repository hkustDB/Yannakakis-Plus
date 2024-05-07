create or replace view aggView2214097201923069247 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin8956986375447964807 as select movie_id as v23, v35 from movie_keyword as mk, aggView2214097201923069247 where mk.keyword_id=aggView2214097201923069247.v8;
create or replace view aggView5886094899996063635 as select v23, MIN(v35) as v35 from aggJoin8956986375447964807 group by v23;
create or replace view aggJoin2083728383848837980 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView5886094899996063635 where t.id=aggView5886094899996063635.v23 and production_year>2010;
create or replace view aggView1239628182332136794 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin2083728383848837980 group by v23;
create or replace view aggJoin8920320958672059250 as select person_id as v14, v35, v37 from cast_info as ci, aggView1239628182332136794 where ci.movie_id=aggView1239628182332136794.v23;
create or replace view aggView4199446451561315233 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin8920320958672059250 group by v14;
create or replace view aggJoin3802129055138579277 as select name as v15, v35, v37 from name as n, aggView4199446451561315233 where n.id=aggView4199446451561315233.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin3802129055138579277;
