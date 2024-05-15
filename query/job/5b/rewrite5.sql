create or replace view aggView5780190542458185349 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5560345360828069710 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5780190542458185349 where mc.company_type_id=aggView5780190542458185349.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView981461785776793295 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin2322920101762141249 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView981461785776793295 where mi.movie_id=aggView981461785776793295.v15 and info IN ('USA','America');
create or replace view aggView1262162000267131431 as select v15 from aggJoin5560345360828069710 group by v15;
create or replace view aggJoin2131281775779899639 as select v3, v13, v27 as v27 from aggJoin2322920101762141249 join aggView1262162000267131431 using(v15);
create or replace view aggView524253670153200876 as select id as v3 from info_type as it;
create or replace view aggJoin5062442158774467007 as select v27 from aggJoin2131281775779899639 join aggView524253670153200876 using(v3);
select MIN(v27) as v27 from aggJoin5062442158774467007;
