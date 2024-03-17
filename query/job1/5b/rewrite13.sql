create or replace view aggView7452736362477881846 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin9151452788731062708 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView7452736362477881846 where mi.movie_id=aggView7452736362477881846.v15 and info IN ('USA','America');
create or replace view aggView7619849619220562317 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin500379112133927830 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7619849619220562317 where mc.company_type_id=aggView7619849619220562317.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView4849828969670410465 as select v15 from aggJoin500379112133927830 group by v15;
create or replace view aggJoin831313540750347434 as select v3, v13, v27 as v27 from aggJoin9151452788731062708 join aggView4849828969670410465 using(v15);
create or replace view aggView6973636350430237734 as select id as v3 from info_type as it;
create or replace view aggJoin126925041330156541 as select v13, v27 from aggJoin831313540750347434 join aggView6973636350430237734 using(v3);
select MIN(v27) as v27 from aggJoin126925041330156541;
