create or replace view aggView8624737319763731598 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6248733069011072141 as select movie_id as v15, note as v9 from movie_companies as mc, aggView8624737319763731598 where mc.company_type_id=aggView8624737319763731598.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView2354087466267873354 as select v15 from aggJoin6248733069011072141 group by v15;
create or replace view aggJoin8166652906539292996 as select id as v15, title as v16, production_year as v19 from title as t, aggView2354087466267873354 where t.id=aggView2354087466267873354.v15 and production_year>2010;
create or replace view aggView1296924799251948418 as select v15, MIN(v16) as v27 from aggJoin8166652906539292996 group by v15;
create or replace view aggJoin7109264568132722681 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView1296924799251948418 where mi.movie_id=aggView1296924799251948418.v15 and info IN ('USA','America');
create or replace view aggView282853711787191876 as select id as v3 from info_type as it;
create or replace view aggJoin916631020258993232 as select v27 from aggJoin7109264568132722681 join aggView282853711787191876 using(v3);
select MIN(v27) as v27 from aggJoin916631020258993232;
