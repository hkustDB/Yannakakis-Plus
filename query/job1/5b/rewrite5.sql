create or replace view aggView6145526803143400517 as select id as v3 from info_type as it;
create or replace view aggJoin2674558396299955070 as select movie_id as v15, info as v13 from movie_info as mi, aggView6145526803143400517 where mi.info_type_id=aggView6145526803143400517.v3 and info IN ('USA','America');
create or replace view aggView6783052947968217635 as select v15 from aggJoin2674558396299955070 group by v15;
create or replace view aggJoin5050036811844499505 as select id as v15, title as v16 from title as t, aggView6783052947968217635 where t.id=aggView6783052947968217635.v15 and production_year>2010;
create or replace view aggView6560085777110166191 as select v15, MIN(v16) as v27 from aggJoin5050036811844499505 group by v15;
create or replace view aggJoin2911105658719591293 as select company_type_id as v1, v27 from movie_companies as mc, aggView6560085777110166191 where mc.movie_id=aggView6560085777110166191.v15 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView6785526542080222743 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2362260900502567586 as select v27 from aggJoin2911105658719591293 join aggView6785526542080222743 using(v1);
select MIN(v27) as v27 from aggJoin2362260900502567586;
