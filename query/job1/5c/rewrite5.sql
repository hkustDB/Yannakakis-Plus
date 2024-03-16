create or replace view aggView7479453368167220618 as select id as v15, title as v27 from title as t where production_year>1990;
create or replace view aggJoin4283852164943470983 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView7479453368167220618 where mi.movie_id=aggView7479453368167220618.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView8964335609436163565 as select id as v3 from info_type as it;
create or replace view aggJoin1777117833623879960 as select v15, v13, v27 from aggJoin4283852164943470983 join aggView8964335609436163565 using(v3);
create or replace view aggView2376789493455773895 as select v15, MIN(v27) as v27 from aggJoin1777117833623879960 group by v15;
create or replace view aggJoin2839072108241631571 as select company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView2376789493455773895 where mc.movie_id=aggView2376789493455773895.v15 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView5702458506453382263 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin546337874651903372 as select v9, v27 from aggJoin2839072108241631571 join aggView5702458506453382263 using(v1);
select MIN(v27) as v27 from aggJoin546337874651903372;
