create or replace view aggView6300631570608927546 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2850406842580363228 as select movie_id as v23, v36 from cast_info as ci, aggView6300631570608927546 where ci.person_id=aggView6300631570608927546.v14;
create or replace view aggView5077490507539323616 as select id as v23, title as v37 from title as t where production_year>2010;
create or replace view aggJoin8837536626476110000 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView5077490507539323616 where mk.movie_id=aggView5077490507539323616.v23;
create or replace view aggView513647690553634906 as select v23, MIN(v36) as v36 from aggJoin2850406842580363228 group by v23;
create or replace view aggJoin3707493596416884334 as select v8, v37 as v37, v36 from aggJoin8837536626476110000 join aggView513647690553634906 using(v23);
create or replace view aggView7970199923651240983 as select v8, MIN(v37) as v37, MIN(v36) as v36 from aggJoin3707493596416884334 group by v8;
create or replace view aggJoin1545618344091540521 as select keyword as v9, v37, v36 from keyword as k, aggView7970199923651240983 where k.id=aggView7970199923651240983.v8 and keyword= 'marvel-cinematic-universe';
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1545618344091540521;
