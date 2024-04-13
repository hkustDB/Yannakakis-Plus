create or replace view aggView4343167747129070279 as select id as v15, title as v27 from title as t where production_year>2005;
create or replace view aggJoin7759158145283807542 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView4343167747129070279 where mc.movie_id=aggView4343167747129070279.v15 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView3861415101961003856 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3760446620047710147 as select v15, v9, v27 from aggJoin7759158145283807542 join aggView3861415101961003856 using(v1);
create or replace view aggView6644456743149949125 as select v15, MIN(v27) as v27 from aggJoin3760446620047710147 group by v15,v27;
create or replace view aggJoin5287894392900772116 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView6644456743149949125 where mi.movie_id=aggView6644456743149949125.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView388748246685556244 as select id as v3 from info_type as it;
create or replace view aggJoin3797526479132133156 as select v27 from aggJoin5287894392900772116 join aggView388748246685556244 using(v3);
select MIN(v27) as v27 from aggJoin3797526479132133156;
