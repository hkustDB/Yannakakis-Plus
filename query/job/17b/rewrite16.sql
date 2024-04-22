create or replace view aggJoin8877545817332590407 as (
with aggView521211860106308163 as (select id as v26, name as v47 from name as n where name LIKE 'Z%')
select movie_id as v3, v47 from cast_info as ci, aggView521211860106308163 where ci.person_id=aggView521211860106308163.v26);
create or replace view aggJoin3728882552427669652 as (
with aggView7093371403563841437 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView7093371403563841437 where mc.company_id=aggView7093371403563841437.v20);
create or replace view aggJoin7269301784786368613 as (
with aggView7297568183908170190 as (select v3 from aggJoin3728882552427669652 group by v3)
select id as v3 from title as t, aggView7297568183908170190 where t.id=aggView7297568183908170190.v3);
create or replace view aggJoin728178867475297425 as (
with aggView8515564237326635710 as (select v3 from aggJoin7269301784786368613 group by v3)
select movie_id as v3, keyword_id as v25 from movie_keyword as mk, aggView8515564237326635710 where mk.movie_id=aggView8515564237326635710.v3);
create or replace view aggJoin116204210447626386 as (
with aggView8422832506227100952 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select v3 from aggJoin728178867475297425 join aggView8422832506227100952 using(v25));
create or replace view aggJoin4476124940919131352 as (
with aggView8262608427432446431 as (select v3 from aggJoin116204210447626386 group by v3)
select v47 as v47 from aggJoin8877545817332590407 join aggView8262608427432446431 using(v3));
select MIN(v47) as v47 from aggJoin4476124940919131352;
