create or replace view aggView6695695635925390056 as select id as v15, title as v27 from title as t where production_year>1990;
create or replace view aggJoin6768024296640115053 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView6695695635925390056 where mc.movie_id=aggView6695695635925390056.v15 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView3793118843472595941 as select id as v3 from info_type as it;
create or replace view aggJoin1731548259644891229 as select movie_id as v15, info as v13 from movie_info as mi, aggView3793118843472595941 where mi.info_type_id=aggView3793118843472595941.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView3748043569784601141 as select v15 from aggJoin1731548259644891229 group by v15;
create or replace view aggJoin8121865607622318577 as select v1, v9, v27 as v27 from aggJoin6768024296640115053 join aggView3748043569784601141 using(v15);
create or replace view aggView4626944194415549033 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin691618685704991931 as select v9, v27 from aggJoin8121865607622318577 join aggView4626944194415549033 using(v1);
select MIN(v27) as v27 from aggJoin691618685704991931;
