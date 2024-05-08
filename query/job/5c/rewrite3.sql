create or replace view aggView1260877308763861634 as select id as v3 from info_type as it;
create or replace view aggJoin2653845057199610401 as select movie_id as v15, info as v13 from movie_info as mi, aggView1260877308763861634 where mi.info_type_id=aggView1260877308763861634.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView8341775202120422313 as select v15 from aggJoin2653845057199610401 group by v15;
create or replace view aggJoin1473247826245631056 as select id as v15, title as v16, production_year as v19 from title as t, aggView8341775202120422313 where t.id=aggView8341775202120422313.v15 and production_year>1990;
create or replace view aggView6474361477489089409 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3928111447338469112 as select movie_id as v15, note as v9 from movie_companies as mc, aggView6474361477489089409 where mc.company_type_id=aggView6474361477489089409.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView1314302997807466576 as select v15 from aggJoin3928111447338469112 group by v15;
create or replace view aggJoin4747674453528054268 as select v16 from aggJoin1473247826245631056 join aggView1314302997807466576 using(v15);
select MIN(v16) as v27 from aggJoin4747674453528054268;
