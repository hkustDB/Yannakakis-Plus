create or replace view aggView9103609479152322082 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6833353924561568772 as select movie_id as v12 from movie_keyword as mk, aggView9103609479152322082 where mk.keyword_id=aggView9103609479152322082.v1;
create or replace view aggView3359884922896672679 as select v12 from aggJoin6833353924561568772 group by v12;
create or replace view aggJoin5594255213273717300 as select id as v12, title as v13 from title as t, aggView3359884922896672679 where t.id=aggView3359884922896672679.v12 and production_year>1990;
create or replace view aggView6232290516726444028 as select v12, MIN(v13) as v24 from aggJoin5594255213273717300 group by v12;
create or replace view aggJoin1373653145163922398 as select v24 from movie_info as mi, aggView6232290516726444028 where mi.movie_id=aggView6232290516726444028.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
select MIN(v24) as v24 from aggJoin1373653145163922398;
