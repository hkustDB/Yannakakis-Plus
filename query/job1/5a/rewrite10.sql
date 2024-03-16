create or replace view aggView6078489774804010908 as select id as v3 from info_type as it;
create or replace view aggJoin7740894954248196145 as select movie_id as v15, info as v13 from movie_info as mi, aggView6078489774804010908 where mi.info_type_id=aggView6078489774804010908.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView156777774043628920 as select v15 from aggJoin7740894954248196145 group by v15;
create or replace view aggJoin5329622729360744743 as select id as v15, title as v16 from title as t, aggView156777774043628920 where t.id=aggView156777774043628920.v15 and production_year>2005;
create or replace view aggView7621968262977831327 as select v15, MIN(v16) as v27 from aggJoin5329622729360744743 group by v15;
create or replace view aggJoin446500585969208275 as select company_type_id as v1, v27 from movie_companies as mc, aggView7621968262977831327 where mc.movie_id=aggView7621968262977831327.v15 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView3948253770644762606 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2764109372625347344 as select v27 from aggJoin446500585969208275 join aggView3948253770644762606 using(v1);
select MIN(v27) as v27 from aggJoin2764109372625347344;
