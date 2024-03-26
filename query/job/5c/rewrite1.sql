create or replace view aggView4560968311789183475 as select id as v3 from info_type as it;
create or replace view aggJoin6706296482935459693 as select movie_id as v15, info as v13 from movie_info as mi, aggView4560968311789183475 where mi.info_type_id=aggView4560968311789183475.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView7840308878044599285 as select v15 from aggJoin6706296482935459693 group by v15;
create or replace view aggJoin5340398001398824910 as select id as v15, title as v16 from title as t, aggView7840308878044599285 where t.id=aggView7840308878044599285.v15 and production_year>1990;
create or replace view aggView8018403939719332644 as select v15, MIN(v16) as v27 from aggJoin5340398001398824910 group by v15;
create or replace view aggJoin9091647607160867796 as select company_type_id as v1, v27 from movie_companies as mc, aggView8018403939719332644 where mc.movie_id=aggView8018403939719332644.v15 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView4254983003900874398 as select v1, MIN(v27) as v27 from aggJoin9091647607160867796 group by v1;
create or replace view aggJoin4656410043090933515 as select v27 from company_type as ct, aggView4254983003900874398 where ct.id=aggView4254983003900874398.v1 and kind= 'production companies';
select MIN(v27) as v27 from aggJoin4656410043090933515;
