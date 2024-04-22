create or replace view aggJoin4392861319508908132 as (
with aggView7422953985279935963 as (select id as v26, name as v47 from name as n where name LIKE 'X%')
select movie_id as v3, v47 from cast_info as ci, aggView7422953985279935963 where ci.person_id=aggView7422953985279935963.v26);
create or replace view aggJoin1481806438075282454 as (
with aggView3186951379571133169 as (select id as v3 from title as t)
select movie_id as v3, company_id as v20 from movie_companies as mc, aggView3186951379571133169 where mc.movie_id=aggView3186951379571133169.v3);
create or replace view aggJoin8852133522657540550 as (
with aggView8345745793962663316 as (select id as v20 from company_name as cn)
select v3 from aggJoin1481806438075282454 join aggView8345745793962663316 using(v20));
create or replace view aggJoin7929327665278841788 as (
with aggView7264518399922358417 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView7264518399922358417 where mk.keyword_id=aggView7264518399922358417.v25);
create or replace view aggJoin2124631793450677525 as (
with aggView5238170873302643845 as (select v3 from aggJoin8852133522657540550 group by v3)
select v3 from aggJoin7929327665278841788 join aggView5238170873302643845 using(v3));
create or replace view aggJoin4485886234225403489 as (
with aggView7443982545352407817 as (select v3 from aggJoin2124631793450677525 group by v3)
select v47 as v47 from aggJoin4392861319508908132 join aggView7443982545352407817 using(v3));
select MIN(v47) as v47 from aggJoin4485886234225403489;
