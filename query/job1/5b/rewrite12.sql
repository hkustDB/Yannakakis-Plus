create or replace view aggView3822182171154106919 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin8354994124505865361 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView3822182171154106919 where mc.movie_id=aggView3822182171154106919.v15 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView846230682495812200 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4217786140669518933 as select v15, v9, v27 from aggJoin8354994124505865361 join aggView846230682495812200 using(v1);
create or replace view aggView3228550954970712965 as select v15, MIN(v27) as v27 from aggJoin4217786140669518933 group by v15;
create or replace view aggJoin6050688041518439719 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView3228550954970712965 where mi.movie_id=aggView3228550954970712965.v15 and info IN ('USA','America');
create or replace view aggView7521489730972712530 as select v3, MIN(v27) as v27 from aggJoin6050688041518439719 group by v3;
create or replace view aggJoin7759727838627315179 as select v27 from info_type as it, aggView7521489730972712530 where it.id=aggView7521489730972712530.v3;
select MIN(v27) as v27 from aggJoin7759727838627315179;
