create or replace view aggView7008678993462658478 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin9017193215495936314 as select id as v12, title as v13 from title as t, aggView7008678993462658478 where t.id=aggView7008678993462658478.v12 and production_year>2005;
create or replace view aggView7824317336200561976 as select v12, MIN(v13) as v24 from aggJoin9017193215495936314 group by v12;
create or replace view aggJoin4410135222282441967 as select keyword_id as v1, v24 from movie_keyword as mk, aggView7824317336200561976 where mk.movie_id=aggView7824317336200561976.v12;
create or replace view aggView2929016530299651923 as select v1, MIN(v24) as v24 from aggJoin4410135222282441967 group by v1;
create or replace view aggJoin4969268969234617491 as select v24 from keyword as k, aggView2929016530299651923 where k.id=aggView2929016530299651923.v1 and keyword LIKE '%sequel%';
select MIN(v24) as v24 from aggJoin4969268969234617491;
