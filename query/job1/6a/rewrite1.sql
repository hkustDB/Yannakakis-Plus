create or replace view aggView2401212111691180330 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin5288319736881533029 as select movie_id as v23, v36 from cast_info as ci, aggView2401212111691180330 where ci.person_id=aggView2401212111691180330.v14;
create or replace view aggView3120327609136545570 as select v23, MIN(v36) as v36 from aggJoin5288319736881533029 group by v23;
create or replace view aggJoin8065485494415217044 as select id as v23, title as v24, v36 from title as t, aggView3120327609136545570 where t.id=aggView3120327609136545570.v23 and production_year>2010;
create or replace view aggView4175854057829339064 as select v23, MIN(v36) as v36, MIN(v24) as v37 from aggJoin8065485494415217044 group by v23;
create or replace view aggJoin3416928640750382501 as select keyword_id as v8, v36, v37 from movie_keyword as mk, aggView4175854057829339064 where mk.movie_id=aggView4175854057829339064.v23;
create or replace view aggView4746805972367901469 as select v8, MIN(v36) as v36, MIN(v37) as v37 from aggJoin3416928640750382501 group by v8;
create or replace view aggJoin4434641949975980028 as select keyword as v9, v36, v37 from keyword as k, aggView4746805972367901469 where k.id=aggView4746805972367901469.v8 and keyword= 'marvel-cinematic-universe';
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4434641949975980028;
