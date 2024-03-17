create or replace view aggView952602968062874207 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin4331918499880848249 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView952602968062874207 where mk.movie_id=aggView952602968062874207.v23;
create or replace view aggView8118596050893325552 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin7934250061078637926 as select movie_id as v23, v36 from cast_info as ci, aggView8118596050893325552 where ci.person_id=aggView8118596050893325552.v14;
create or replace view aggView6455717143515187204 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin4292752455979536935 as select v23, v37, v35 from aggJoin4331918499880848249 join aggView6455717143515187204 using(v8);
create or replace view aggView6640669642037911270 as select v23, MIN(v36) as v36 from aggJoin7934250061078637926 group by v23;
create or replace view aggJoin1521697126311891391 as select v37 as v37, v35 as v35, v36 from aggJoin4292752455979536935 join aggView6640669642037911270 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1521697126311891391;
