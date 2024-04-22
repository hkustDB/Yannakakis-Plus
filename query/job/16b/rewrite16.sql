create or replace view aggJoin1741312481665251297 as (
with aggView186274099130672217 as (select person_id as v2, MIN(name) as v55 from aka_name as an group by person_id)
select id as v2, v55 from name as n, aggView186274099130672217 where n.id=aggView186274099130672217.v2);
create or replace view aggJoin6772286317251551229 as (
with aggView572424575916817417 as (select id as v11, title as v56 from title as t)
select person_id as v2, movie_id as v11, v56 from cast_info as ci, aggView572424575916817417 where ci.movie_id=aggView572424575916817417.v11);
create or replace view aggJoin6401809512726090254 as (
with aggView5198966483407257895 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView5198966483407257895 where mc.company_id=aggView5198966483407257895.v28);
create or replace view aggJoin9205520064533831757 as (
with aggView339771949887051550 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView339771949887051550 where mk.keyword_id=aggView339771949887051550.v33);
create or replace view aggJoin2353479520858696084 as (
with aggView167153797342262678 as (select v2, MIN(v55) as v55 from aggJoin1741312481665251297 group by v2,v55)
select v11, v56 as v56, v55 from aggJoin6772286317251551229 join aggView167153797342262678 using(v2));
create or replace view aggJoin8127871697961138830 as (
with aggView8700082245701265576 as (select v11 from aggJoin6401809512726090254 group by v11)
select v11 from aggJoin9205520064533831757 join aggView8700082245701265576 using(v11));
create or replace view aggJoin7814106420201918822 as (
with aggView3659941485847958056 as (select v11 from aggJoin8127871697961138830 group by v11)
select v56 as v56, v55 as v55 from aggJoin2353479520858696084 join aggView3659941485847958056 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin7814106420201918822;
