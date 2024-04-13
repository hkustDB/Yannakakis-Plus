create or replace view aggView8536595916760171231 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin8837314863242559142 as select movie_id as v23, v35 from movie_keyword as mk, aggView8536595916760171231 where mk.keyword_id=aggView8536595916760171231.v8;
create or replace view aggView6380545282398387023 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin9186248742232653256 as select v23, v35, v37 from aggJoin8837314863242559142 join aggView6380545282398387023 using(v23);
create or replace view aggView6188424061498224114 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin1729804594774861430 as select movie_id as v23, v36 from cast_info as ci, aggView6188424061498224114 where ci.person_id=aggView6188424061498224114.v14;
create or replace view aggView9125077994979083066 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin9186248742232653256 group by v23,v37,v35;
create or replace view aggJoin5390496170744466024 as select v36 as v36, v35, v37 from aggJoin1729804594774861430 join aggView9125077994979083066 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin5390496170744466024;
