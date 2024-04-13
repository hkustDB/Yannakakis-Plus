create or replace view aggView4925604329718140732 as select id as v15, title as v27 from title as t where production_year>1990;
create or replace view aggJoin5454678157506847016 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView4925604329718140732 where mc.movie_id=aggView4925604329718140732.v15 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView5534018410994694016 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin868413884679007684 as select v15, v9, v27 from aggJoin5454678157506847016 join aggView5534018410994694016 using(v1);
create or replace view aggView7359608409898500343 as select v15, MIN(v27) as v27 from aggJoin868413884679007684 group by v15,v27;
create or replace view aggJoin6864380050695325616 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView7359608409898500343 where mi.movie_id=aggView7359608409898500343.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView3949756585639744340 as select id as v3 from info_type as it;
create or replace view aggJoin1162455881127702969 as select v27 from aggJoin6864380050695325616 join aggView3949756585639744340 using(v3);
select MIN(v27) as v27 from aggJoin1162455881127702969;
