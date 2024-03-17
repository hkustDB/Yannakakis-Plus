create or replace view aggView4460469262333502781 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin4318778680087624219 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView4460469262333502781 where mk.movie_id=aggView4460469262333502781.v12;
create or replace view aggView1107071256996922987 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin610417380367915100 as select v1, v24 as v24 from aggJoin4318778680087624219 join aggView1107071256996922987 using(v12);
create or replace view aggView3341299249081870921 as select v1, MIN(v24) as v24 from aggJoin610417380367915100 group by v1;
create or replace view aggJoin2202745234606685119 as select keyword as v2, v24 from keyword as k, aggView3341299249081870921 where k.id=aggView3341299249081870921.v1 and keyword LIKE '%sequel%';
select MIN(v24) as v24 from aggJoin2202745234606685119;
