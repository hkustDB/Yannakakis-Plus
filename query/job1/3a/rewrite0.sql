create or replace view aggView429629928479682743 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin7626929597842013963 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView429629928479682743 where mi.movie_id=aggView429629928479682743.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView1069809349294723 as select v12, MIN(v24) as v24 from aggJoin7626929597842013963 group by v12;
create or replace view aggJoin7068319151230718248 as select keyword_id as v1, v24 from movie_keyword as mk, aggView1069809349294723 where mk.movie_id=aggView1069809349294723.v12;
create or replace view aggView7485054834181957484 as select v1, MIN(v24) as v24 from aggJoin7068319151230718248 group by v1;
create or replace view aggJoin8209277504537641488 as select keyword as v2, v24 from keyword as k, aggView7485054834181957484 where k.id=aggView7485054834181957484.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin8209277504537641488;
select sum(v24) from res;