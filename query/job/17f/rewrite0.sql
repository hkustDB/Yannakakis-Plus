create or replace view aggJoin5170034532156875041 as (
with aggView2138093213272138953 as (select id as v3 from title as t)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView2138093213272138953 where ci.movie_id=aggView2138093213272138953.v3);
create or replace view aggJoin5606924078963514102 as (
with aggView2029726224647080114 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView2029726224647080114 where mk.keyword_id=aggView2029726224647080114.v25);
create or replace view aggJoin4195092524208402939 as (
with aggView7906625335572504224 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView7906625335572504224 where mc.company_id=aggView7906625335572504224.v20);
create or replace view aggJoin2836966725787416872 as (
with aggView2671471179456227028 as (select v3 from aggJoin4195092524208402939 group by v3)
select v3 from aggJoin5606924078963514102 join aggView2671471179456227028 using(v3));
create or replace view aggJoin1394836045490212944 as (
with aggView7774044496256625909 as (select v3 from aggJoin2836966725787416872 group by v3)
select v26 from aggJoin5170034532156875041 join aggView7774044496256625909 using(v3));
create or replace view aggJoin2435374945037248923 as (
with aggView4695004604857551532 as (select v26 from aggJoin1394836045490212944 group by v26)
select name as v27 from name as n, aggView4695004604857551532 where n.id=aggView4695004604857551532.v26);
create or replace view aggJoin7563485854963700624 as (
with aggView7407796659709264116 as (select v27 from aggJoin2435374945037248923 group by v27)
select v27 from aggView7407796659709264116 where v27 LIKE '%B%');
select MIN(v27) as v47 from aggJoin7563485854963700624;
