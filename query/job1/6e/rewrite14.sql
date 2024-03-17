create or replace view aggView3371098049532567641 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin7614606854558567663 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView3371098049532567641 where ci.movie_id=aggView3371098049532567641.v23;
create or replace view aggView1754253100597883257 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin5567129641908491032 as select v23, v37, v36 from aggJoin7614606854558567663 join aggView1754253100597883257 using(v14);
create or replace view aggView8151615403624602134 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin4486637581789045462 as select movie_id as v23, v35 from movie_keyword as mk, aggView8151615403624602134 where mk.keyword_id=aggView8151615403624602134.v8;
create or replace view aggView2511621322940843057 as select v23, MIN(v35) as v35 from aggJoin4486637581789045462 group by v23;
create or replace view aggJoin1875606550541073214 as select v37 as v37, v36 as v36, v35 from aggJoin5567129641908491032 join aggView2511621322940843057 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1875606550541073214;
