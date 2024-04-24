create or replace view aggView8178669471810789205 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin7779089987321662887 as select movie_id as v23, v35 from movie_keyword as mk, aggView8178669471810789205 where mk.keyword_id=aggView8178669471810789205.v8;
create or replace view aggView6932786227533006122 as select id as v23, title as v37 from title as t where production_year>2010;
create or replace view aggJoin3158642982906356428 as select v23, v35, v37 from aggJoin7779089987321662887 join aggView6932786227533006122 using(v23);
create or replace view aggView1537150012560498484 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3547874576490914158 as select movie_id as v23, v36 from cast_info as ci, aggView1537150012560498484 where ci.person_id=aggView1537150012560498484.v14;
create or replace view aggView4930898246012801348 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin3158642982906356428 group by v23,v37,v35;
create or replace view aggJoin4875109290243543851 as select v36 as v36, v35, v37 from aggJoin3547874576490914158 join aggView4930898246012801348 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4875109290243543851;
