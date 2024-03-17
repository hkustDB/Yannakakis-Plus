create or replace view aggView6494937937610786222 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4352899863385373567 as select movie_id as v12 from movie_keyword as mk, aggView6494937937610786222 where mk.keyword_id=aggView6494937937610786222.v1;
create or replace view aggView5452242106604845455 as select v12 from aggJoin4352899863385373567 group by v12;
create or replace view aggJoin5575926607518926979 as select id as v12, title as v13 from title as t, aggView5452242106604845455 where t.id=aggView5452242106604845455.v12 and production_year>1990;
create or replace view aggView7746440270748173902 as select v12, MIN(v13) as v24 from aggJoin5575926607518926979 group by v12;
create or replace view aggJoin4590339274485378185 as select v24 from movie_info as mi, aggView7746440270748173902 where mi.movie_id=aggView7746440270748173902.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
select MIN(v24) as v24 from aggJoin4590339274485378185;
