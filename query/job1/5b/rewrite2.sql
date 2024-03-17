create or replace view aggView5000059909173816936 as select id as v3 from info_type as it;
create or replace view aggJoin8667176353038438366 as select movie_id as v15, info as v13 from movie_info as mi, aggView5000059909173816936 where mi.info_type_id=aggView5000059909173816936.v3 and info IN ('USA','America');
create or replace view aggView5775391430730248235 as select v15 from aggJoin8667176353038438366 group by v15;
create or replace view aggJoin7117167246229629198 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView5775391430730248235 where mc.movie_id=aggView5775391430730248235.v15 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView7643695863937132811 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5996659801709278917 as select v15, v9 from aggJoin7117167246229629198 join aggView7643695863937132811 using(v1);
create or replace view aggView8152831974389261295 as select v15 from aggJoin5996659801709278917 group by v15;
create or replace view aggJoin1747885814207090874 as select title as v16 from title as t, aggView8152831974389261295 where t.id=aggView8152831974389261295.v15 and production_year>2010;
select MIN(v16) as v27 from aggJoin1747885814207090874;
