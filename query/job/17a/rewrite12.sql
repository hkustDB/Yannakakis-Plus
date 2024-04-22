create or replace view aggJoin8065960838785486386 as (
with aggView251946440860447387 as (select id as v26, name as v47 from name as n where name LIKE 'B%')
select movie_id as v3, v47 from cast_info as ci, aggView251946440860447387 where ci.person_id=aggView251946440860447387.v26);
create or replace view aggJoin5719787588373293321 as (
with aggView5988237208443959910 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView5988237208443959910 where mc.company_id=aggView5988237208443959910.v20);
create or replace view aggJoin9161054484505906489 as (
with aggView8387428058550421482 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView8387428058550421482 where mk.keyword_id=aggView8387428058550421482.v25);
create or replace view aggJoin285733008169741120 as (
with aggView4131805942257687324 as (select v3 from aggJoin9161054484505906489 group by v3)
select v3 from aggJoin5719787588373293321 join aggView4131805942257687324 using(v3));
create or replace view aggJoin6859171350370849308 as (
with aggView651880454990246176 as (select v3 from aggJoin285733008169741120 group by v3)
select id as v3 from title as t, aggView651880454990246176 where t.id=aggView651880454990246176.v3);
create or replace view aggJoin8684630186936472439 as (
with aggView7225046773309388209 as (select v3 from aggJoin6859171350370849308 group by v3)
select v47 as v47 from aggJoin8065960838785486386 join aggView7225046773309388209 using(v3));
select MIN(v47) as v47 from aggJoin8684630186936472439;
