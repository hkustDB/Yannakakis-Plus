create or replace view aggView6725699031607378478 as select title as v44, id as v11 from title as t;
create or replace view aggView1789893797322496594 as select name as v3, person_id as v2 from aka_name as an group by name,person_id;
create or replace view aggJoin7125113410750603164 as (
with aggView7453911484774458282 as (select v2, MIN(v3) as v55 from aggView1789893797322496594 group by v2)
select person_id as v2, movie_id as v11, v55 from cast_info as ci, aggView7453911484774458282 where ci.person_id=aggView7453911484774458282.v2);
create or replace view aggJoin8662396399458904845 as (
with aggView7598543052139361037 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView7598543052139361037 where mc.company_id=aggView7598543052139361037.v28);
create or replace view aggJoin7400283247555576262 as (
with aggView7893642475279131642 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView7893642475279131642 where mk.keyword_id=aggView7893642475279131642.v33);
create or replace view aggJoin3278691105701014837 as (
with aggView5900209522748823232 as (select id as v2 from name as n)
select v11, v55 from aggJoin7125113410750603164 join aggView5900209522748823232 using(v2));
create or replace view aggJoin1064028102186891949 as (
with aggView7571410424738702450 as (select v11 from aggJoin8662396399458904845 group by v11)
select v11 from aggJoin7400283247555576262 join aggView7571410424738702450 using(v11));
create or replace view aggJoin149880699257725349 as (
with aggView707439798045709906 as (select v11 from aggJoin1064028102186891949 group by v11)
select v11, v55 as v55 from aggJoin3278691105701014837 join aggView707439798045709906 using(v11));
create or replace view aggJoin6886225844972183708 as (
with aggView1760692309733137854 as (select v11, MIN(v55) as v55 from aggJoin149880699257725349 group by v11,v55)
select v44, v55 from aggView6725699031607378478 join aggView1760692309733137854 using(v11));
select MIN(v55) as v55,MIN(v44) as v56 from aggJoin6886225844972183708;
