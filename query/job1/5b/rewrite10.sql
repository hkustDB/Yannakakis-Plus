create or replace view aggView52830487974678468 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin1566292405887791420 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView52830487974678468 where mi.movie_id=aggView52830487974678468.v15 and info IN ('USA','America');
create or replace view aggView8667347595638246441 as select id as v3 from info_type as it;
create or replace view aggJoin2694608745886332979 as select v15, v13, v27 from aggJoin1566292405887791420 join aggView8667347595638246441 using(v3);
create or replace view aggView1080531884913409283 as select v15, MIN(v27) as v27 from aggJoin2694608745886332979 group by v15;
create or replace view aggJoin1652602801601056496 as select company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView1080531884913409283 where mc.movie_id=aggView1080531884913409283.v15 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView3415528547078119715 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3940477870623597437 as select v9, v27 from aggJoin1652602801601056496 join aggView3415528547078119715 using(v1);
select MIN(v27) as v27 from aggJoin3940477870623597437;
