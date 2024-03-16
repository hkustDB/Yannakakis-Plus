create or replace view aggView1904207798367931800 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8989749280079345575 as select movie_id as v23, v36 from cast_info as ci, aggView1904207798367931800 where ci.person_id=aggView1904207798367931800.v14;
create or replace view aggView3036446953356922511 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin411871855396218707 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView3036446953356922511 where mk.movie_id=aggView3036446953356922511.v23;
create or replace view aggView5513757272728067226 as select v23, MIN(v36) as v36 from aggJoin8989749280079345575 group by v23;
create or replace view aggJoin6543883448866040081 as select v8, v37 as v37, v36 from aggJoin411871855396218707 join aggView5513757272728067226 using(v23);
create or replace view aggView74786169601970457 as select v8, MIN(v37) as v37, MIN(v36) as v36 from aggJoin6543883448866040081 group by v8;
create or replace view aggJoin1717393143817737035 as select keyword as v9, v37, v36 from keyword as k, aggView74786169601970457 where k.id=aggView74786169601970457.v8 and keyword= 'marvel-cinematic-universe';
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1717393143817737035;
