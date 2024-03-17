create or replace view aggView8423790725345497024 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin135200665428893961 as select movie_id as v15, note as v9 from movie_companies as mc, aggView8423790725345497024 where mc.company_type_id=aggView8423790725345497024.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView8180254797277876605 as select v15 from aggJoin135200665428893961 group by v15;
create or replace view aggJoin6721338494309630054 as select id as v15, title as v16 from title as t, aggView8180254797277876605 where t.id=aggView8180254797277876605.v15 and production_year>2010;
create or replace view aggView7821098181836566434 as select v15, MIN(v16) as v27 from aggJoin6721338494309630054 group by v15;
create or replace view aggJoin7826514895373349826 as select info_type_id as v3, v27 from movie_info as mi, aggView7821098181836566434 where mi.movie_id=aggView7821098181836566434.v15 and info IN ('USA','America');
create or replace view aggView7216971432102244791 as select id as v3 from info_type as it;
create or replace view aggJoin5299508508117232089 as select v27 from aggJoin7826514895373349826 join aggView7216971432102244791 using(v3);
select MIN(v27) as v27 from aggJoin5299508508117232089;
