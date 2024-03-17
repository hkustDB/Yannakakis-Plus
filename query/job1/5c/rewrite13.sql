create or replace view aggView7994064894812427919 as select id as v15, title as v27 from title as t where production_year>1990;
create or replace view aggJoin7396714741284831507 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView7994064894812427919 where mc.movie_id=aggView7994064894812427919.v15 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView6567610308211790652 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8414376784608301559 as select v15, v9, v27 from aggJoin7396714741284831507 join aggView6567610308211790652 using(v1);
create or replace view aggView8263811515760406327 as select id as v3 from info_type as it;
create or replace view aggJoin3689710812581604948 as select movie_id as v15, info as v13 from movie_info as mi, aggView8263811515760406327 where mi.info_type_id=aggView8263811515760406327.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView8532962649567301621 as select v15 from aggJoin3689710812581604948 group by v15;
create or replace view aggJoin1903245953549397040 as select v9, v27 as v27 from aggJoin8414376784608301559 join aggView8532962649567301621 using(v15);
select MIN(v27) as v27 from aggJoin1903245953549397040;
